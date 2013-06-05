# -*- coding: utf-8 -*-

module DevTools::Cli
  class Comp < Thor
    namespace :comp

    desc "start #{DevTools::Constants::Config::PROJECTS.join("|")} [options]", "Starts components on nodes."
    method_option :node, :type => :string, :desc => "The name of a node whose components we want to start.", :aliases => :n
    def start(project)
      if options[:node]
        DevTools::Node.new(options[:node]).comps[project].each { |comp|
          comp.start
        }
      else
        DevTools::Component.enabled(project).each {|comp| comp.start}
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
