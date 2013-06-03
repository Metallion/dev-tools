# -*- coding: utf-8 -*-

module DevTools::Cli
  class Root < Thor
    desc "start", "Starts all nodes"
    def start
      DevTools::Node.enabled.each {|node| node.start }
    end
  end
end
