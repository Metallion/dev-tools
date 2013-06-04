# -*- coding: utf-8 -*-

module DevTools::Cli
  class NFS < Thor
    namespace :nfs

    desc "start", "Starts the local NFS server."
    def start
      DevTools::NFS.start
    end

    desc "mount [options]", "Mounts the nfs server on one or all nodes"
    method_option :all, :type => :boolean, :default => false, :desc => "Mount nfs for all nodes", :aliases => :a
    method_option :node, :type => :string, :desc => "The name of a node to mount nfs for", :aliases => :n
    def mount
      if options[:all]
        DevTools::Node.enabled.each {|node|
          DevTools::NFS.enabled.each {|nfs|
            nfs.mount(node)
          }
        }
      else
        DevTools::NFS.enabled.each {|nfs|
          nfs.mount(DevTools::Node.new(options[:node]))
        }
      end
    end
  end
end
