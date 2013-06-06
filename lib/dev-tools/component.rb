# -*- coding: utf-8 -*-

module DevTools
  class Component
    attr_reader :node

    def self.enabled(project, comp = nil)
      DevTools::Node.enabled.map { |node|
        if comp
          node.get_comp(project,comp)
        else
          node.comps[project]
        end
      }.flatten.compact
    end

    def initialize(node,project,name)
      @node = node
      @project = project
      @name = name
      path = "#{DT_ROOT}/lib/dev-tools/components/#{@project}/#{@name}.conf"

      @conf = DevTools::Config::Comp.load(path)
    end

    def name
      @conf.name
    end

    def start
      @node.run(@conf.start_cmd)
    end

    def stop
      @node.run(@conf.stop_cmd)
    end

    def show_log?
      @conf.show_log
    end

    def log_path
      @conf.log_path
    end
  end
end
