module Powify
  class Client
    class << self
      def run(args = [])
        begin
          if args[0] && args[0].strip != 'help'
            return Powify::Server.run(args[1..-1]) if args[0].strip == 'server'
            return Powify::App.run(args)
          end
        rescue Exception => e
          $stdout.puts "\nThe command '#{args.last}' does not exist!"
          #$stdout.puts e
        end
        
        help
      end
      
      def help
        $stdout.puts ""
        $stdout.puts "  [SERVER COMMANDS]"
        $stdout.puts "    powify server install       install pow server"
        $stdout.puts "    powify server reinstall     reinstall pow server"
        $stdout.puts "    powify server update        update pow server"
        $stdout.puts "    powify server uninstall     uninstall pow server"
        $stdout.puts "    powify server list          list all pow apps"
        $stdout.puts "    powify server start         start the pow server"
        $stdout.puts "    powify server stop          stop the pow server"
        $stdout.puts "    powify server restart       restart the pow server"
        $stdout.puts "    powify server status        print the current server status"
        $stdout.puts "    powify server config        print the current server configuration"
        $stdout.puts "    powify server logs          tails the pow server logs"
        $stdout.puts ""
        $stdout.puts "  [APP COMMANDS]"
        $stdout.puts "    powify create               creates a pow app from the current directory"
        $stdout.puts "    powify destroy              destroys the pow app linked to the current directory"
        $stdout.puts "    powify restart              restarts the pow app linked to the current directory"
        $stdout.puts "    powify rename [NAME]        rename the pow app to [NAME]"
        $stdout.puts "    powify browse               opens and navigates the default browser to this app"
        $stdout.puts "    powify logs                 tail the application logs"
        $stdout.puts ""
      end
    end
  end
end