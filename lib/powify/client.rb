module Powify
  class Client
    extend Powify
    class << self
      def run(args = [])
        begin
          if args[0] && args[0].strip != 'help'
            return Powify::Server.run(args[1..-1]) if args[0].strip == 'server'
            return Powify::Utils.run(args[1..-1]) if args[0].strip == 'utils'
            return Powify::App.run(args)
          end
        rescue Exception => e
          $stdout.puts e
        end

        help
      end

      def help
        $stdout.puts ""
        $stdout.puts "  [SERVER COMMANDS]"
        $stdout.puts "    powify server install            install pow server"
        $stdout.puts "    powify server reinstall          reinstall pow server"
        $stdout.puts "    powify server update             update pow server"
        $stdout.puts "    powify server uninstall          uninstall pow server"
        $stdout.puts "    powify server list               list all pow apps"
        $stdout.puts "    powify server start              start the pow server"
        $stdout.puts "    powify server stop               stop the pow server"
        $stdout.puts "    powify server restart            restart the pow server"
        $stdout.puts "    powify server host               adds all pow apps to /etc/hosts file"
        $stdout.puts "    powify server unhost             removes all pow apps from /etc/hosts file"
        $stdout.puts "    powify server status             print the current server status"
        $stdout.puts "    powify server config             print the current server configuration"
        $stdout.puts "    powify server logs               tails the pow server logs"
        $stdout.puts ""
        $stdout.puts "  [UTILS COMMANDS]"
        $stdout.puts "    powify utils install             install powify.dev server management tool"
        $stdout.puts "    powify utils reinstall           reinstall powify.dev server management tool"
        $stdout.puts "    powify utils uninstall           uninstall powify.dev server management tool"
        $stdout.puts ""
        $stdout.puts "  [APP COMMANDS]"
        $stdout.puts "    powify create [NAME]             creates a pow app from the current directory"
        $stdout.puts "    powify destroy [NAME]            destroys the pow app linked to the current directory"
        $stdout.puts "    powify restart [NAME]            restarts the pow app linked to the current directory"
        $stdout.puts "    powify always_restart [NAME]     reload the pow app after each request"
        $stdout.puts "    powify always_restart_off [NAME] do not reload the pow app after each request"
        $stdout.puts "    powify rename [NAME]             rename the pow app to [NAME]"
        $stdout.puts "    powify rename [OLD] [NEW]        rename the pow app [OLD] to [NEW]"
        $stdout.puts "    powify environment [ENV]         run the this pow app in a different environment (aliased `env`)"
        $stdout.puts "    powify browse [NAME]             opens and navigates the default browser to this app"
        $stdout.puts "    powify logs [NAME]               tail the application logs"
        $stdout.puts ""
      end
    end
  end
end