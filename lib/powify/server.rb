# pow server functions
# invoked via pow server [COMMAND] [ARGS]
module Powify
  class Server
    class << self
      AVAILABLE_METHODS = %w(install reinstall update uninstall remove list help)
      
      def run(args = [])
        method = args[0].to_s.downcase
        return help unless AVAILABLE_METHODS.include?(method)
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
      
      # List all active POW applications currently on the server
      def list
        $stdout.puts "The following POW applications are available:\n\n"
        Dir["#{POWPATH}/*"].each { |a| $stdout.puts "  #{File.basename(a)} -> #{File.readlink(a)}" }
        $stdout.puts "\nRun `pow open [APP_NAME]` to browse an app"
      end
    end
  end
end