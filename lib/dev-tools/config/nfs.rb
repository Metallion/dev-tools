# -*- coding: utf-8 -*-

module DevTools::Config
  class NFS < Fuguta::Configuration
    param :name
    param :mountpoint
    param :bind_location
    param :real_location
    param :server_ip
  end
end
