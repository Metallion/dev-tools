# -*- coding: utf-8 -*-

module DevTools::Cli
  class Comp < Thor
    namespace :comp

    no_tasks {
      def start_stop(project,comp,node,action)
        #action should be :start or :stop
        if node
          comps = if comp
            [DevTools::Node.new(node).get_comp(project,comp)]
          else
            DevTools::Node.new(node).comps[project]
          end

          comps.each { |c|
            c.send(action)
          }
        else
          DevTools::Component.enabled(project,comp).each {|c| c.send(action)}
        end
      end
    }

    desc "start #{DevTools::Constants::Config::PROJECTS.join("|")} [options]", "Starts components on nodes. Running this without options starts all components on all nodes for a project."
    method_option :comp, :type => :string, :desc => "The name of the component we want to start.", :aliases => :c
    method_option :node, :type => :string, :desc => "The name of the node whose components we want to start.", :aliases => :n
    def start(project)
      start_stop(project,options[:comp],options[:node],:start)
    end

    desc "stop #{DevTools::Constants::Config::PROJECTS.join("|")} [options]", "Stops components on nodes. Running this without options stops all components on all nodes for a project."
    method_option :comp, :type => :string, :desc => "The name of the component we want to stop.", :aliases => :c
    method_option :node, :type => :string, :desc => "The name of the node whose components we want to stop.", :aliases => :n
    def stop(project)
      start_stop(project,options[:comp],options[:node],:stop)
    end

    desc "restart #{DevTools::Constants::Config::PROJECTS.join("|")} [options]", "Restarts components on nodes. Running this without options restarts all components on all nodes for a project."
    method_option :comp, :type => :string, :desc => "The name of the component we want to restart.", :aliases => :c
    method_option :node, :type => :string, :desc => "The name of the node whose components we want to restart.", :aliases => :n
    def restart(project)
      start_stop(project,options[:comp],options[:node],:stop)
      start_stop(project,options[:comp].options[:node],:start)
    end
  end
end
