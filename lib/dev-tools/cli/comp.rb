# -*- coding: utf-8 -*-

module DevTools::Cli
  class Comp < Thor
    namespace :comp

    desc "start #{DevTools::Constants::Config::PROJECTS.join("|")} [options]", "Starts components on nodes."
    def start(project)
      DevTools::Node.enabled.each {|node|
        node.comps[project].each { |comp|
          comp.start
        }
      }
    end

    desc "stop #{DevTools::Constants::Config::PROJECTS.join("|")}", "Stops components on nodes."
    def stop(project)
      DevTools::Node.enabled.each { |node|
        node.comps[project].each { |comp|
          comp.stop
        }
      }
    end
  end
end
