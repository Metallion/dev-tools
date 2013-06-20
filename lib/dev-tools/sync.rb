# -*- coding: utf-8 -*-

module DevTools
  class Sync
    def self.start(node = nil)
      if node
        DevTools::Component.new(node,"common","sync").start
      else
        DevTools::Shell.run("/opt/btsync/btsync --config /etc/btsync/btsync.conf")
      end
    end

    def self.stop(node = nil)
      if node
        DevTools::Component.new(node,"common","sync").stop
      else
        DevTools::Shell.run("'kill `cat /opt/btsync/btsync.pid`'")
      end
    end

    def self.restart(node = nil)
      stop(node)
      start(node)
    end
  end
end
