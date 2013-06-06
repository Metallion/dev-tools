# -*- coding: utf-8 -*-

module DevTools::Cli
  class Comp < Thor
    namespace :comp

    desc "start #{DevTools::Constants::Config::PROJECTS.join("|")} [options]", "Starts components on nodes. Running this without options starts all components on all nodes for a project."
    method_option :comp, :type => :string, :desc => "A name of a component we want to start. Must be used in conjunction with --node or --all.", :aliases => :c
    method_option :node, :type => :string, :desc => "The name of a node whose components we want to start.", :aliases => :n
    def start(project)
      if options[:node]
        comps = if options[:comp]
          [DevTools::Node.new(options[:node]).get_comp(project,options[:comp])]
        else
          DevTools::Node.new(options[:node]).comps[project]
        end

        comps.each { |comp|
          comp.start
        }
      else
        DevTools::Component.enabled(project,options[:comp]).each {|comp| comp.start}
      end
    end

    desc "stop #{DevTools::Constants::Config::PROJECTS.join("|")} [options]", "Stops components on nodes."
    method_option :node, :type => :string, :desc => "The name of a node whose components we want to start.", :aliases => :n
    def stop(project)
      if options[:node]
        DevTools::Node.new(options[:node]).comps[project].each { |comp|
          comp.start
        }
      else
        DevTools::Component.enabled(project).each {|comp| comp.stop}
      end
    end
  end
end
