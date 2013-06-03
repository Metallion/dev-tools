# -*- coding: utf-8 -*-

module DevTools::Config
  class DevTools < Fuguta::Configuration
    param :enabled_nodes

    param :bridge_ip
    param :bridge_ip_prefix
    param :bridge_devname, :default => "br0"

    param :internet_nic, :default => "eth0"
  end
end
