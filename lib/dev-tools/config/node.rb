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

    param :nfs_mounts, :default => ::DevTools.conf.enabled_nfs

    param :username, :default => "root"
    param :ip_address

    # Decides which projects this node is a part of
    # Can hold either "vnet", "vdc" or both
    param :projects, :default => []

    # Decides which components of a project this node has
    param :vdc_comps, :default => []
    param :vnet_comps, :default => []
  end
end
