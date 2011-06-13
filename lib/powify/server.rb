require 'json'

# pow server functions
# invoked via pow server [COMMAND] [ARGS]
module Powify
  class Server
    
    AVAILABLE_METHODS = %w(install reinstall update uninstall remove start stop restart status config list logs help)
    
    class << self
      def run(args = [])
        method = args[0].to_s.downcase
        raise "The command `#{args.first}` does not exist for pow server!" unless Powify::Server::AVAILABLE_METHODS.include?(method)
        self.send(method)
      end
      
      private
      # Install the POW server
      def install
        $stdout.puts "Installing/Re-installing/Updating pow server..."
        %x{curl get.pow.cx | sh}
        $stdout.puts "Done!"
      end
      alias_method :reinstall, :install
      alias_method :update, :install
      
      # Uninstall the POW server
      def uninstall
        $stdout.puts "Uninstalling/Removing pow server..."
        %x{curl get.pow.cx/uninstall.sh | sh}
        $stdout.puts "Done!"
      end
      alias_method :remove, :uninstall
      
      # Start the POW server (command taken from 37 Signals installation script)
      def start
        $stdout.puts "Starting the pow server..."
        %x{launchctl load "$HOME/Library/LaunchAgents/cx.pow.powd.plist"}
        $stdout.puts "Done!"
      end
      
      # Stop the POW server (command taken from 37 Signals installation script)
      def stop
        $stdout.puts "Stopping the pow server..."
        %x{launchctl unload "$HOME/Library/LaunchAgents/cx.pow.powd.plist"}
        $stdout.puts "Done!"
      end
      
      # Restart the POW server
      def restart
        stop
        start
      end
      
      # Print the current POW server status
      def status
        $stdout.puts "The current status of the pow server is:\n\n"
        result = %x{curl localhost/status.json --silent --header host:pow}
        json = JSON.parse(result)
        json.each_pair { |k,v| $stdout.puts "  #{k}: #{v}" }
        $stdout.puts "\n"
      end
      
      # Print the current POW server configuration
      def config
        $stdout.puts "The current configuration of the pow server is:\n\n"
        result = %x{curl localhost/config.json --silent --header host:pow}
        json = JSON.parse(result)
        json.each_pair {|k,v| $stdout.puts "  #{k}: #{v}"}
        $stdout.puts "\n"
      end
      
      # List all active POW applications currently on the server
      def list
        $stdout.puts "The following POW applications are available:\n\n"
        Dir["#{POWPATH}/*"].each { |a| $stdout.puts "  #{File.basename(a)} -> #{File.readlink(a)}" }
        $stdout.puts "\nRun `pow open [APP_NAME]` to browse an app"
      end
      
      # tail the server logs
      def logs
        system "tail -f ~/Library/Logs/Pow/access.log"
      end
    end
  end
end