# -*- coding: utf-8 -*-

module DevTools::Config
  class Node < Fuguta::Configuration
    param :name
    param :image_location
    param :memory_size, :default => 3072
    param :cpu, :default => "host"
    param :cores, :default => 4
    param :vnc_port
    param :mac_addr

    param :username, :default => "root"
    param :ip_address

    param :vdc_comps, :default => []
    param :vnet_comps, :default => []
  end
end
