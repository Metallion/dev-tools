# -*- coding: utf-8 -*-

module DevTools
  class Node
    # These are all the components that this node has
    # Format:
    # {
    #   vdc => ["mysql", "dcmgr", "collector"],
    #   vnet => ["redis", "vnmgr", "dba"]
    # }
    attr_reader :comps

    def self.enabled
      DevTools.conf.enabled_nodes.map {|node_name|
        Node.new(node_name)
      }
    end

    def self.enabled_with_comp(project,comp)
      enabled.find {|node| node.has_comp?(comp) }
    end

    def self.db_node(project)
      enabled_with_comp(project,"mysql")
    end

    def initialize(name)
      path = "#{DevTools::Constants::Config::PATH}/nodes/#{name}.conf"
      @conf = DevTools::Config::Node.load(path)

      @comps = {}
      DevTools::Constants::Config::PROJECTS.each { |project_name|
        @comps[project_name] = []
        @conf.send("#{project_name}_comps").each { |comp_name|
          @comps[project_name] << DevTools::Component.new(self,project_name,comp_name)
        }
      }
    end

    def has_comp?(project,comp)
      get_comp ? true : false
    end

    def get_comp(project,comp_name)
      self.comps[project].find{|c|c.name == comp_name}
    end

    def name
      @conf.name
    end

    def start
      cmd = ""
      cmd += "qemu-system-x86_64 "
      cmd += "-m #{@conf.memory_size} "
      cmd += "-cpu #{@conf.cpu} "
      cmd += "-smp #{@conf.cores} "
      cmd += "-enable-kvm "
      cmd += "-hda #{@conf.image_location} "
      cmd += "-vnc :#{@conf.vnc_port} "
      cmd += "-net nic,macaddr=#{@conf.mac_addr} -net tap "

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
      ip = @conf.ip_address

      "ssh -i #{key} #{user}@#{ip} #{cmd}"
    end

    def enter
      key = DevTools::Constants::Config::SSH_PRIVATE_KEY_PATH
      user = @conf.username
      ip = @conf.ip_address

      DevTools::Shell.run("ssh -i #{key} #{user}@#{ip}")
    end
  end
end
