# -*- coding: utf-8 -*-

module DevTools::Config
  class Comp
    param :start_cmd
    param :stop_cmd

    param :show_log?, :default => false
    param :log_file, :default => nil
  end

  def validate
    errors << "show_log? set to true but no log file defined." if @config[:show_log?] && !@config[:log_file]
  end
end
