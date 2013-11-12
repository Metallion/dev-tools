# -*- coding: utf-8 -*-

module DevTools::Config
  class DevTools < Fuguta::Configuration
    param :enabled_nodes
    param :enabled_nfs

    param :bridges

    param :internet_nic, :default => "eth0"
  end
end
