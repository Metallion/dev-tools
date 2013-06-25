# -*- coding: utf-8 -*-

module DevTools
  class Screen
    def initialize(title)
      @title = title
    end

    def init
      DevTools::Shell.run("tmux new -ds #{@title}")
    end

    def open(subtitle,cmd)
      DevTools::Shell.run("tmux new-window -t #{@title} -n #{subtitle}")
      DevTools::Shell.run("tmux send -t #{@title} '#{cmd}' ENTER")
    end

    def attach
      DevTools::Shell.run("tmux attach -t #{@title}")
    end
  end
end
