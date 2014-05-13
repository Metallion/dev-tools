# -*- coding: utf-8 -*-

module DevTools::Config
  class Node < Fuguta::Configuration
    param :name
    param :image_location
    param :memory_size, :default => 3072
    param :cpu, :default => "host"
    param :cores, :default => 4
    param :vnc_port
    param :vifs

    param :nfs_mounts, :default => ::DevTools.conf.enabled_nfs

    param :username, :default => "root"
    param :ssh_ipv4

    # Decides which projects this node is a part of
    # Can hold either "vnet", "vdc" or both
    param :projects, :default => []

    # Set this to true to stop dev-tools from trying to manage kvm for this node
    param :physical, :default => false

    # Decides which components of a project this node has
    param :vdc_comps, :default => []
    param :vnet_comps, :default => []
  end
end
