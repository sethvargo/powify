require 'json'
# powify server functions
# invoked via powify utils [COMMAND] [ARGS]
module Powify
  class Utils
    extend Powify
    AVAILABLE_METHODS = %w(install reinstall uninstall remove help)

    class << self
      def run(args = [])
        method = args[0].to_s.downcase
        raise "The command `#{args.first}` does not exist for `powify utils`!" unless Powify::Utils::AVAILABLE_METHODS.include?(method)
        self.send(method)
      end

      # Install powify.dev
      def install
        uninstall
        $stdout.puts "Cloning powify.dev from github and bundling powify.dev..."
        %x{git clone -q git@github.com:sethvargo/powify.dev.git powify && cd powify && bundle install --deployment && cd .. && mv powify "#{config['hostRoot']}"}
        $stdout.puts "Done!"
      end
      alias_method :reinstall, :install

      # Uninstall powify.dev
      def uninstall
        %x{rm -rf "#{config['hostRoot']}/powify"}
        $stdout.puts "Successfully removed powify.dev"
      end
      alias_method :remove, :uninstall
    end
  end
end