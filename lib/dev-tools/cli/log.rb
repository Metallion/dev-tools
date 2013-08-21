# -*- coding: utf-8 -*-

module DevTools::Cli
  class Log < Thor
    namespace 'log'

    desc "show #{DevTools.projects_list} [options]", "Show the "
    method_option :node, :type => :string, :desc => "The name of a node whose log to show.", :aliases => :n
    def show(project)
      screen = DevTools::Screen.new(project)
      screen.init

      comps = if options[:node]
        DevTools::Node.new(options[:node]).comps[project]
      else
        DevTools::Component.enabled(project)
      end
      comps.each{ |comp|
        next unless comp.show_log?
        screen.open("#{comp.node.name}-#{comp.name}",
          comp.node.get_run_cmd("tail -f #{comp.log_path}")
        )
      }

      screen.attach
    end
  end
end
