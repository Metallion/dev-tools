# -*- coding: utf-8 -*-

module DevTools
  class Screen
    def initialize(title)
      @title = title
    end

    def init
      DevTools::Shell.run("screen -L -d -m -S #{@title} -t #{@title}")
    end

    def open(subtitle,cmd)
      DevTools::Shell.run("screen -L -r #{@title} -x -X screen -t #{subtitle}")
      DevTools::Shell.run("screen -L -r #{@title} -x -p #{subtitle} -X stuff '#{cmd}\n'")
    end

    def attach
      DevTools::Shell.run("screen -x #{@title}")
    end
  end
end
