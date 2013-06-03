# -*- coding: utf-8 -*-

module DevTools
  class Node
    def initialize(name)
      path = "#{DevTools::Constants::Config::PATH}/#{name}.conf"
      @conf = DevTools::Config::Node.load(path)
    end

    def start
      cmd = ""
      cmd += "qemu-system-x86_64 "
      cmd += "-m #{@conf.memory_size} "
      cmd += "-cpu #{@conf.cpu} "
      cmd += "-smp #{@conf.cores} "
      cmd += "-enable-kvm "
      cmd += "-hva #{@conf.image_location} "
      cmd += "-vnc :#{@conf.vnc_port} "
      cmd += "-net nic,macaddr=#{@conf.mac_addr} -net tap "

      puts "starting #{@conf.name}"
      pid = spawn(cmd)
      Process.detach pid
    end
  end
end
