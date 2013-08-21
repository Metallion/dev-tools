# -*- coding: utf-8 -*-

module DevTools::Cli
  class DB < Thor
    namespace :db

    desc "reset #{DevTools.projects_list}", "Resets the database for a project."
    def reset(project)
      case project
      when "vdc"
        #TODO: Get rid of this ugly hard coded path
        DevTools::Node.db_node(project).run("vdc_data=/var/lib/wakame-vdc /opt/axsh/wakame-vdc/tests/vdc.sh init")
      when "vnet"
        raise NotImplementedError, "db reset vnet"
      else
        raise DevTools::Errors::UnknownProjectError, "#{project}"
      end
    end
  end
end
