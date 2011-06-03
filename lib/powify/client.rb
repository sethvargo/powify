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
          $stdout.puts e
        end
        
        help
      end
      
      def help
        $stdout.puts ""
        $stdout.puts "  [SERVER COMMANDS]"
        $stdout.puts "    pow server install       install pow server"
        $stdout.puts "    pow server reinstall     reinstall pow server"
        $stdout.puts "    pow server update        update pow server"
        $stdout.puts "    pow server uninstall     uninstall pow server"
        $stdout.puts "    pow server list          list all pow apps"
        $stdout.puts "    pow server logs          tails the pow server logs"
        $stdout.puts ""
        $stdout.puts "  [APP COMMANDS]"
        $stdout.puts "    pow create               creates a pow app from the current directory"
        $stdout.puts "    pow destroy              destroys the pow app linked to the current directory"
        $stdout.puts "    pow restart              restarts the pow app linked to the current directory"
        $stdout.puts "    pow rename [NAME]        rename the pow app to [NAME]"
        $stdout.puts "    pow browse               opens and navigates the default browser to this app"
        $stdout.puts "    pow logs                 tail the application logs"
        $stdout.puts ""
      end
    end
  end
end