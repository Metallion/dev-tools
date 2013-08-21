# -*- coding: utf-8 -*-

module DevTools::Cli
  class Root < Thor
    desc "start #{DevTools.projects_list} [options]", "Does a bunch in initial settings and starts all enabled nodes."
    method_option :no_bridge, :type => :boolean, :default => false, :desc => "Don't create the bridge."
    method_option :no_nodes, :type => :boolean, :default => false, :desc => "Don't start the nodes."
    def start(project)
      raise "Must be run as root" unless Process.uid == 0
      unless options[:no_bridge]
        c = DevTools.conf
        bridge = DevTools::Bridge.new(c.bridge_ip,c.bridge_ip_prefix,c.bridge_devname)
        bridge.create
        bridge.share_internet(c.internet_nic)
      end

      DevTools::Node.enabled(project).each {|node| node.start } unless options[:no_nodes]
    end

    desc "stop #{DevTools.projects_list}", "Stops all nodes."
    def stop(project)
      DevTools::Node.enabled(project).each {|node| node.stop }
    end

    desc "enter", "SSH's into a node."
    def enter(node)
      DevTools::Node.new(node).enter
    end

    register(DevTools::Cli::Sync, DevTools::Cli::Sync.namespace, "sync", "Operations for syncing folders between nodes.")
    register(DevTools::Cli::DB, DevTools::Cli::DB.namespace, "db", "Operations for project databases.")
    register(DevTools::Cli::Node, DevTools::Cli::Node.namespace, "node", "Operations for nodes.")
    register(DevTools::Cli::Comp, DevTools::Cli::Comp.namespace, "comp", "Operations for node components.")
    register(DevTools::Cli::Log, DevTools::Cli::Log.namespace, "log", "Operations for component logs.")
    register(DevTools::Cli::NFS, DevTools::Cli::NFS.namespace, "nfs", "Operations for NFS mounts.")
  end
end
