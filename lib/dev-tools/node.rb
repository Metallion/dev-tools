# -*- coding: utf-8 -*-

module DevTools
  class Node
    # These are all the components that this node has
    # Format:
    # {
    #   vdc => ["mysql", "dcmgr", "collector"],
    #   vnet => ["redis", "vnmgr", "dba"]
    # }
    attr_reader :name
    attr_reader :comps
    attr_reader :projects

    def self.enabled(project = nil)
      nodes = DevTools.conf.enabled_nodes.map {|node_name|
        Node.new(node_name)
      }

      nodes.delete_if {|node| !node.projects.member?(project) } if project

      nodes
    end

    def self.enabled_with_comp(project,comp)
      enabled.find {|node| node.has_comp?(project,comp) }
    end

    def self.db_node(project)
      enabled_with_comp(project,"mysql")
    end

    def initialize(name)
      @name = name
      path = "#{DevTools::Constants::Config::PATH}/nodes/#{name}.conf"
      @conf = DevTools::Config::Node.load(path)

      @projects = @conf.projects

      @comps = {}
      DevTools::Constants::Config::PROJECTS.each { |project_name|
        @comps[project_name] = []
        @conf.send("#{project_name}_comps").each { |comp_name|
          @comps[project_name] << DevTools::Component.new(self,project_name,comp_name)
        }
      }
    end

    def has_comp?(project,comp)
      get_comp(project,comp) ? true : false
    end

    def get_comp(project,comp_name)
      self.comps[project].find{|c|c.name == comp_name}
    end

    def name
      @conf.name
    end

    def start
      cmd = "qemu-system-x86_64 " +
         "-m #{@conf.memory_size} " +
         "-cpu #{@conf.cpu} " +
         "-smp #{@conf.cores} " +
         "-enable-kvm " +
         "-hda #{@conf.image_location} " +
         "-vnc :#{@conf.vnc_port} "

      conf_path = DevTools::Constants::Config::PATH
      @conf.vifs.each { |vif|
        cmd += "-net nic,macaddr=#{vif[:mac_addr]} " +
          "-net tap,script=#{conf_path}/bridges/#{vif[:bridge]}/qemu-ifup," +
          "downscript=#{conf_path}/bridges/#{vif[:bridge]}/qemu-ifdown "
      }

      DevTools.logger.info "starting #{@conf.name}"
      pid = spawn(cmd)
      Process.detach pid
    end

    def stop
      DevTools.logger.info "stopping #{@conf.name}"
      run("poweroff")
    end

    def run(cmd)
      DevTools::Shell.run(get_run_cmd(cmd))
    end

    def get_run_cmd(cmd)
      key = DevTools::Constants::Config::SSH_PRIVATE_KEY_PATH
      user = @conf.username
      ip = @conf.ssh_ipv4

      "ssh -i #{key} #{user}@#{ip} #{cmd}"
    end

    def enter
      key = DevTools::Constants::Config::SSH_PRIVATE_KEY_PATH
      user = @conf.username
      ip = @conf.ssh_ipv4

      DevTools::Shell.run("ssh -i #{key} #{user}@#{ip}")
    end
  end
end
