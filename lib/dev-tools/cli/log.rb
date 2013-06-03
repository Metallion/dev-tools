# -*- coding: utf-8 -*-

module DevTools::Cli
  class Log < Thor
    namespace 'log'

    desc "show #{DevTools::Constants::Config::PROJECTS.join("|")}", "Show the "
    def show(project)
      screen = DevTools::Screen.new(project)
      screen.init

      DevTools::Node.enabled.each { |node|
        node.comps[project].each { |comp|
          screen.open("#{project}-#{comp.name}","tail -f #{comp.log_path}")
        }
      }

      screen.attach
    end
  end
end
