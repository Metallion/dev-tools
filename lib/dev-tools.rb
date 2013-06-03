# -*- coding: utf-8 -*-

require 'rubygems'
require 'logger'

module DevTools
  DT_ROOT = File.expand_path('../..',__FILE__)

  def self.conf
    @conf
  end

  def self.logger
    @logger ||= ::Logger.new(STDOUT)
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
    autoload :Comp, 'dev-tools/cli/comp'
  end

  autoload :Node, 'dev-tools/node'
  autoload :Component, 'dev-tools/component'
  autoload :Shell, 'dev-tools/shell'
  autoload :Bridge, 'dev-tools/bridge'
  autoload :Logger, 'dev-tools/logger'

  module Constants
    autoload :NFS, 'dev-tools/constants/nfs'
    autoload :Config, 'dev-tools/constants/config'
  end
end
