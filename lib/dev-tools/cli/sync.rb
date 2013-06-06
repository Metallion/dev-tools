# -*- coding: utf-8 -*-

module DevTools::Cli
  class Sync < Thor
    namespace :sync

    desc "start [options]", "Starts the sync service on the host, a node or all nodes"
    method_option :host, :type => :boolean, :desc => "Start sync on the host", :aliases => :h
    method_option :all, :type => :boolean, :desc => "Start sync on all nodes", :aliases => :a
    method_option :node, :type => :string, :desc => "Start sync on a specific node", :aliases => :n
    def start
      DevTools::Sync.start if options[:host]
      nodes = if options[:all]
        DevTools::Node.enabled
      elsif options[:node]
        [DevTools::Node.new(options[:node])]
      else
        []
      end

      nodes.each {|node| DevTools::Sync.start(node) }
    end
  end
end
