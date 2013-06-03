# -*- coding: utf-8 -*-

module DevTools
  class Node

    def self.enabled
      DevTools.conf.enabled_nodes.map {|node_name|
        Node.new(node_name)
      }
    end

    def initialize(name)
      path = "#{DevTools::Constants::Config::PATH}/nodes/#{name}.conf"
      @conf = DevTools::Config::Node.load(path)
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

    def run(cmd)
      key = DevTools::Constants::Config::SSH_PRIVATE_KEY_PATH
      user = @conf.username
      ip = @conf.ip_address

      DevTools.logger.info "stopping #{@conf.name}"
      DevTools::Shell.run("ssh -i #{key} #{user}@#{ip} #{cmd}")
    end

    def enter
      key = DevTools::Constants::Config::SSH_PRIVATE_KEY_PATH
      user = @conf.username
      ip = @conf.ip_address

      DevTools::Shell.run("ssh -i #{key} #{user}@#{ip}")
    end
  end
end
