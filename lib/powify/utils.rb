# powify server functions
# invoked via powify utils [COMMAND] [ARGS]
module Powify
  class Utils

    AVAILABLE_METHODS = %w(install reinstall uninstall remove help)

    class << self
      def run(args = [])
        method = args[0].to_s.downcase
        raise "The command `#{args.first}` does not exist for `powify utils`!" unless Powify::Utils::AVAILABLE_METHODS.include?(method)
        self.send(method)
      end

      protected
      # Install powify.dev
      def install
        uninstall
        %x{git clone git@github.com:sethvargo/powify.dev.git powify && mv powify #{self.config['hostRoot']}}
      end
      alias_method :reinstall, :install

      # Uninstall powify.dev
      def uninstall
        %x{rm -rf #{self.config['hostRoot']}/powify}
      end
      alias_method :remove, :uninstall
    end
  end
end