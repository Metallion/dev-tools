# -*- coding: utf-8 -*-

module DevTools::Cli
  class Comp < Thor
    namespace :comp

    desc "start vdc|vnet [options]", "Starts components on nodes."
    def start(project)
      DevTools::Node.enabled.each {|node|
        node.comps[project].each { |comp|
          comp.start
        }
      }
    end
  end
end
