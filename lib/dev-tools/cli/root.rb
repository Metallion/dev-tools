# -*- coding: utf-8 -*-

module DevTools::Cli
  class Root < Thor
    desc "start [options]", "Starts all nodes"
    method_option :no_bridge, :type => :boolean, :default => false, :desc => "Don't create the bridge."
    method_option :no_nodes, :type => :boolean, :default => false, :desc => "Don't start the nodes."
    def start
      unless options[:no_bridge]
        c = DevTools.conf
        bridge = DevTools::Bridge.new(c.bridge_ip,c.bridge_ip_prefix,c.bridge_devname)
        bridge.create
        bridge.share_internet(c.internet_nic)
      end

      DevTools::Node.enabled.each {|node| node.start } unless options[:no_nodes]
    end

    desc "stop", "Stops all nodes"
    def stop
      DevTools::Node.enabled.each {|node| node.run("poweroff") }
    end
  end
end
