# -*- coding: utf-8 -*-

require 'rubygems'

module DevTools

  def self.conf
    @conf
  end

  module Config
    require 'fuguta'
    autoload :Node, 'dev-tools/config/node'
    autoload :Comp, 'dev-tools/config/comp'
    autoload :DevTools, 'dev-tools/config/dev-tools'
  end

  module Cli
    require 'thor'
    autoload :Root, 'dev-tools/cli/root'
  end

  autoload :Node, 'dev-tools/node'

  module Constants
    autoload :NFS, 'dev-tools/constants/nfs'
    autoload :Config, 'dev-tools/constants/config'
  end
end
