# -*- coding: utf-8 -*-

module DevTools::Cli
  class Log < Thor
    namespace 'log'

    desc "show #{DevTools::Constants::Config::PROJECTS.join("|")}", "Show the "
    def show(project)
      screen = DevTools::Screen.new(project)
      screen.init

      DevTools::Component.enabled(project).each {|comp|
        screen.open("#{comp.node.name}-#{comp.name}","tail -f #{comp.log_path}")
      }

      screen.attach
    end
  end
end
