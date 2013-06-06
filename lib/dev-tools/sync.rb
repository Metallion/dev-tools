# -*- coding: utf-8 -*-

module DevTools
  class Sync
    def self.start(node = nil)
      if node
        DevTools::Component.new(node,"common","sync").start
      else
        DevTools::Shell.run("systemctl start btsync.service")
      end
    end

    def stop(node = nil)
      if node
        DevTools::Component.new(node,"common","sync").stop
      else
        DevTools::Shell.run("systemctl stop btsync.service")
      end
    end
  end
end
