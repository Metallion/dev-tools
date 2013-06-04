# -*- coding: utf-8 -*-

module DevTools
  class NFS
    def self.enabled
      DevTools::Constants::NFS::DEFAULT_MOUNTS.map { |mount| NFS.new(mount) }
    end

    def self.start
      enabled.each {|nfs| nfs.bind }
      DevTools::Shell.run("systemctl start rpc-idmapd.service")
      DevTools::Shell.run("systemctl start rpc-mountd.service")
    end

    def initialize(nfs_cfg)
      cfg_path = "#{DevTools::Constants::Config::PATH}/nfs/#{nfs_cfg}.conf"
      @conf = DevTools::Config::NFS.load(cfg_path)
    end

    def bind
      DevTools::Shell.run("mount --bind #{@conf.real_location} #{@conf.bind_location}")
    end

    def mount(node)
      DevTools.logger.info "mounting #{@conf.name} on #{node.name}"
      node.run("mount -t nfs #{DevTools.conf.bridge_ip}:#{@conf.bind_location} #{@conf.mountpoint}")
    end
  end
end
