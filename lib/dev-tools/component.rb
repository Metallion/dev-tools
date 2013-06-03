# -*- coding: utf-8 -*-

module DevTools
  class Component
    def initialize(node,project,name)
      @node = node
      @project = project
      @name = name
      path = "#{DT_ROOT}/lib/dev-tools/components/#{@project}/#{@name}.conf"

      @conf = DevTools::Config::Comp.load(path)
    end

    def start
      @node.run(@conf.start_cmd)
    end

    def stop
      @node.run(@conf.stop_cmd)
    end
  end
end
