require 'json'

# powify server functions
# invoked via powify server [COMMAND] [ARGS]
module Powify
  class Server

    AVAILABLE_METHODS = %w(install reinstall update uninstall remove start stop restart host unhost status config list logs help)

    class << self
      def run(args = [])
        method = args[0].to_s.downcase
        raise "The command `#{args.first}` does not exist for `powify server`!" unless Powify::Server::AVAILABLE_METHODS.include?(method)
        self.send(method)
      end

      protected
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

      # Adds POW domains to the hosts file
      #
      # Original Author: Christopher Lindblom (https://github.com/lindblom)
      # Original Context: https://github.com/lindblom/powder/commit/8b2f2609e91ddbc72f53c7fbb6daee92a82e21c0
      #
      # This method was taken from Christopher Lindlom pull request to powder, a similar gem for managing
      # pow applications. I DID NOT write this code (although I tested it), so don't give me any credit!
      def host
        hosts_file_path = "/etc/hosts"
        pow_domain_records = Dir[POW_PATH + "/*"].map { |a| "127.0.0.1\t#{File.basename(a)}.#{domain}\t#powder" }
        hosts_file = File.read("/etc/hosts").split("\n").delete_if {|row| row =~ /.+(#powder)/}
        first_loopback_index = hosts_file.index {|i| i =~ /^(127.0.0.1).+/}
        hosts_file = hosts_file.insert(first_loopback_index + 1, pow_domain_records)
        File.open("#{ENV['HOME']}/hosts-powder", "w")  do
          |file| file.puts hosts_file.join("\n")
        end
        %x{cp #{hosts_file_path} #{ENV['HOME']}/hosts-powder.bak}
        %x{sudo mv #{ENV['HOME']}/hosts-powder #{hosts_file_path}}
        %x{dscacheutil -flushcache}
        $stdout.puts "Domains added to hosts file, old host file is saved at #{ENV['HOME']}/hosts-powder.bak"
      end

      # Adds POW domains to the hosts file
      #
      # Original Author: Christopher Lindblom (https://github.com/lindblom)
      # Original Context: https://github.com/lindblom/powder/commit/8b2f2609e91ddbc72f53c7fbb6daee92a82e21c0
      #
      # This method was taken from Christopher Lindlom pull request to powder, a similar gem for managing
      # pow applications. I DID NOT write this code (although I tested it), so don't give me any credit!
      def unhost
        hosts_file_path = "/etc/hosts"
        hosts_file = File.read("/etc/hosts").split("\n").delete_if {|row| row =~ /.+(#powder)/}
        File.open("#{ENV['HOME']}/hosts-powder", "w")  do
          |file| file.puts hosts_file.join("\n")
        end
        %x{cp #{hosts_file_path} #{ENV['HOME']}/hosts-powder.bak}
        %x{sudo mv #{ENV['HOME']}/hosts-powder #{hosts_file_path}}
        %x{dscacheutil -flushcache}
        $stdout.puts "Domains removed from hosts file, old host file is saved at #{ENV['HOME']}/hosts-powder.bak"
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
        $stdout.puts "\nRun `powify open [APP_NAME]` to browse an app"
      end

      # tail the server logs
      def logs
        system "tail -f ~/Library/Logs/Pow/access.log"
      end
    end
  end
end