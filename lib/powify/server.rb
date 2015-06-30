require 'json'

# powify server functions
# invoked via powify server [COMMAND] [ARGS]
module Powify
  class Server
    extend Powify
    AVAILABLE_METHODS = %w(install reinstall update uninstall remove start stop restart host unhost status config list logs)

    class << self
      def run(args = [])
        method = args[0].to_s.downcase
        raise "The command `#{args.first}` does not exist for `powify server`!" unless Powify::Server::AVAILABLE_METHODS.include?(method)
        self.send(method)
      end

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
        %x{sudo launchctl load -Fw /Library/LaunchDaemons/cx.pow.firewall.plist 2>/dev/null}
        %x{launchctl load -Fw "$HOME/Library/LaunchAgents/cx.pow.powd.plist" 2>/dev/null}
        $stdout.puts "Done!"
      end

      # Stop the POW server (command taken from 37 Signals installation script)
      def stop
        $stdout.puts "Stopping the pow server..."
        %x{launchctl unload "$HOME/Library/LaunchAgents/cx.pow.powd.plist" 2>/dev/null}
        %x{sudo launchctl unload "/Library/LaunchDaemons/cx.pow.firewall.plist" 2>/dev/null}
        $stdout.puts "Done!"
      end

      # Restart the POW server
      def restart
        stop
        start
      end

      # Add POW domains to the hosts file
      #
      # Original Author: Christopher Lindblom (https://github.com/lindblom)
      # Original Context: https://github.com/lindblom/powder/commit/8b2f2609e91ddbc72f53c7fbb6daee92a82e21c0
      #
      # This method was taken from Christopher Lindlom pull request to powder, a similar gem for managing
      # pow applications. I DID NOT write this code (although I tested it), so don't give me any credit!
      def host
        hosts_file_path = '/etc/hosts'
        hosts_file = File.read(hosts_file_path)
        return $stdout.puts 'Pow is already in the hosts file. Please run `powify server unhost`' if hosts_file =~ /(#powify)/ || File.exists?("#{hosts_file_path}.powify.bak")

        # break our hosts file into lines
        hosts_file = hosts_file.split("\n")
        pow_domains = Dir["#{POWPATH}/*"].collect { |a| "127.0.0.1\t#{File.basename(a)}.#{extension}\t#powify" }

        # find the loop back and insert our domains after
        first_loopback_index = hosts_file.index{ |i| i =~ /^(127.0.0.1).+/ }
        hosts_file = hosts_file.insert(first_loopback_index + 1, pow_domains)

        %x{sudo cp #{hosts_file_path} #{hosts_file_path}.powify.bak}
        File.open(hosts_file_path, 'w+') { |f| f.puts hosts_file.join("\n") }

        %x{dscacheutil -flushcache}
        $stdout.puts "All Pow apps were added to the hosts file."
        $stdout.puts "The old host file is saved at #{hosts_file_path}.powify.bak."
      end

      # Remove POW domains from the hosts file
      #
      # Original Author: Christopher Lindblom (https://github.com/lindblom)
      # Original Context: https://github.com/lindblom/powder/commit/8b2f2609e91ddbc72f53c7fbb6daee92a82e21c0
      #
      # This method was taken from Christopher Lindlom pull request to powder, a similar gem for managing
      # pow applications. I DID NOT write this code (although I tested it), so don't give me any credit!
      def unhost
        hosts_file_path = '/etc/hosts'
        hosts_file = File.read(hosts_file_path)
        return $stdout.puts 'Pow is not in the host file, and there is no backup file. Please run `powify server host`' unless hosts_file =~ /.+(#powify)/ || File.exists?("#{hosts_file_path}.powify.bak")

        hosts_file = hosts_file.split("\n").delete_if { |row| row =~ /.+(#powify)/ } # remove any existing records

        File.open(hosts_file_path, 'w+') { |f| f.puts hosts_file.join("\n") }
        %x{sudo rm #{hosts_file_path}.powify.bak}

        %x{dscacheutil -flushcache}
        $stdout.puts "All Pow apps were removed from the hosts file."
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

      def _extract_forward_info(port)
        res_types = { 'p' => :pid, 'c' => :command }
        result = %x{lsof -iTCP:#{port} -Fpc}
        Hash[ result.split("\n").map { |line| [ res_types[line[0]], line[1..-1] ] } ]
      end
      # List all active POW applications currently on the server
      def list
        $stdout.puts "The following POW applications are available:\n\n"
        Dir["#{POWPATH}/*"].each do |a|
          if File.symlink?(a)
            $stdout.puts "  #{File.basename(a)} -> #{File.readlink(a)}"
          else
            port = File.open(a) { |f| f.readline.to_i }
            info = _extract_forward_info(port)
            $stdout.puts "  #{File.basename(a)} -> forwarding to :#{port} for" +
                         " #{info.fetch(:command, 'Unknown')}[#{info.fetch(:pid, '???')}]"
          end
        end
        $stdout.puts "\nRun `powify open [APP_NAME]` to browse an app"
      end

      # Tail the server logs
      def logs
        system "tail -f ~/Library/Logs/Pow/access.log"
      end
    end
  end
end
