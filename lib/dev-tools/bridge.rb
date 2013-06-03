# -*- coding: utf-8 -*-

module DevTools
  class Bridge
    attr_accessor :ip
    attr_accessor :prefix
    attr_accessor :devname

    def initialize(ip,prefix,devname)
      @ip = ip
      @prefix = prefix
      @devname = devname
    end

    def create
      DevTools::Shell.run("brctl addbr #{@devname}")
      DevTools::Shell.run("ip addr add #{@ip}/#{@prefix} dev #{@devname}")
      DevTools::Shell.run("ip link set #{@devname} up")
    end

    def destroy
      DevTools::Shell.run("ip link set #{@devname} down")
    end

    def share_internet(internet_nic)
      DevTools::Shell.run("sysctl net.ipv4.ip_forward=1")
      DevTools::Shell.run("iptables -t nat -A POSTROUTING -o #{internet_nic} -j MASQUERADE")
    end
  end
end
