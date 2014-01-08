# -*- coding: utf-8 -*-

module DevTools::Cli
  class Node < Thor
    namespace :node

    desc "start", "starts a node"
    def start(node_cfg)
      DevTools::Node.new(node_cfg).start
    end

    desc "stop", "stops a node"
    def stop(node_cfg)
      DevTools::Node.new(node_cfg).stop
    end

    desc "runcmd NODE COMMAND [SSH_OPTIONS]", "runs a command on a node"
    def runcmd(node_cfg, cmd, options = "")
      DevTools::Node.new(node_cfg).run(cmd)
    end
  end
end
