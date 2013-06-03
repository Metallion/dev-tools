# -*- coding: utf-8 -*-

module DevTools
  class Shell
    # Wrapper method to allow me to change the way we execute
    # shell commands globally whenever I want.
    def self.run(cmd)
      system(cmd)
    end
  end
end
