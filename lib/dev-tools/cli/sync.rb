# -*- coding: utf-8 -*-

module DevTools::Cli
  class Sync < Thor
    PA=DevTools::Constants::Component::POSSIBLE_ACTIONS
    namespace :sync

    no_tasks {
      def start_stop(host,all,node,action)
        raise "Impossible action: #{action.inspect}. Possible actions are: #{PA.map{|a| a.inspect}.join(",")}" unless PA.member?(action)
        DevTools::Sync.send(action) if host
        nodes = if all
          DevTools::Node.enabled
        elsif node
          [DevTools::Node.new(node)]
        else
          []
        end

        nodes.each {|node| DevTools::Sync.send(action,node) }
      end
    }

    PA.each { |action|
      capital_action = action.to_s.slice(0,1).capitalize + action.to_s.slice(1..-1)

      desc "#{action} [options]", "#{capital_action}s the sync service on the host, a node or all nodes"
      method_option :host, :type => :boolean, :desc => "#{capital_action} sync on the host", :aliases => :h
      method_option :all, :type => :boolean, :desc => "#{capital_action} sync on all nodes", :aliases => :a
      method_option :node, :type => :string, :desc => "#{capital_action} sync on a specific node", :aliases => :n
      define_method(action) do
        start_stop(options[:host],options[:all],options[:node],action)
      end
    }
  end
end
