module Utility
  class SystemInfo
    def self.os
      os = :linux

      if RUBY_PLATFORM =~ /cygwin|mswin|mingw|bccwin|wince|emx/
        os = :windows
      elsif RUBY_PLATFORM =~ /darwin/
        os = :mac
      end

      os
    end

    def self.root?
      Process.uid == 0 && os != :windows
    end

    # @param app_name [String]
    # @return [String, false] string path if a path was determined
    def self.config_path(app_name)
      case os
        when :windows
          File.join(ENV.fetch('APPDATA'), app_name).tr('\\', '/') # Fixes an issue with Dir[path/*]
        when :mac
          File.join(ENV.fetch('HOME'), 'Library', 'Application Support', app_name)
        when :linux
          if ENV['XDG_CONFIG_HOME']
            File.join(ENV.fetch('XDG_CONFIG_HOME'), app_name)
          else
            File.join(ENV.fetch('HOME'), '.config', app_name)
          end
        else
          false
      end
    end
  end
end
