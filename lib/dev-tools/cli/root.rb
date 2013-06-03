# -*- coding: utf-8 -*-

module DevTools::Cli
  class Root < Thor
    desc "start", "Starts all nodes"
    def start
      c = DevTools.conf
      bridge = DevTools::Bridge.new(c.bridge_ip,c.bridge_ip_prefix,c.bridge_devname)
      bridge.create
      bridge.share_internet(c.internet_nic)

      DevTools::Node.enabled.each {|node| node.start }
    end

    desc "stop", "Stops all nodes"
    def stop
      DevTools::Node.enabled.each {|node| node.run("poweroff") }
    end
  end
end
