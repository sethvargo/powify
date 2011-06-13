require 'fileutils'

module Powify
  class App
    
    AVAILABLE_METHODS = %w(create link new destroy unlink remove restart browse open rename logs help)
    
    class << self
      def run(args)
        method = args[0].strip.to_s.downcase
        return Powify::Client.help unless Powify::App::AVAILABLE_METHODS.include?(method)
        self.send(method, args[1..-1])
      end
      
      def create(args = [])
        return unless is_pow?
        app_name = args[0] ? args[0].strip.to_s.downcase : File.basename(current_path)
        symlink_path = "#{POWPATH}/#{app_name}"
        FileUtils.ln_s(current_path, symlink_path)
        $stdout.puts "Successfully created pow app #{app_name}!"
        $stdout.puts "Type `powify browse #{app_name}` to open the application in your browser."
      end
      alias_method :link, :create
      alias_method :new, :create
      
      def destroy(args = [])
        return unless is_pow?
        app_name = args[0] ? args[0].strip.to_s.downcase : File.basename(current_path)
        symlink_path = "#{POWPATH}/#{app_name}"
        if File.exists?
          FileUtils.rm(symlink_path)
          $stdout.puts "Successfully destroyed pow app #{app_name}!"
          $stdout.puts "If this was an accident, type `powify create #{app_name}` to re-create the app."
        else
          $stdout.puts "Powify could not find an app named `app_name` on this server."
          $stdout.puts "By default, powify tries to look for an application with the same name as the current directory."
          $stdout.puts "If your application has a different name than the working directory, you'll need to specify in the command:"
          $stdout.puts "\n\n\tpowify destroy [NAME]\n\n"
          $stdout.puts "If your app was named `foo`, you would type:"
          $stdout.puts "\n\n\tpowify destroy foo\n\n"
        end
      end
      alias_method :unlink, :destroy
      alias_method :remove, :destroy
      
      def restart(args = [])
        return unless is_pow?
        app_name = args[0] ? args[0].strip.to_s.downcase : File.basename(current_path)
        symlink_path = "#{POWPATH}/#{app_name}"
        if File.exists?(symlink_path)
          FileUtils.mkdir_p("#{symlink_path}/tmp")
          %x{touch #{symlink_path}/tmp/restart.txt}
          $stdout.puts "Successfully restarted #{app_name}!"
        else
          $stdout.puts "Powify could not find an app to restart with the name #{app_name}"
          Powify::Server.list
        end
      end
      
      def browse(args = [])
        app_name = args[0] ? args[0].strip.to_s.downcase : File.basename(current_path)
        ext = args[1] || extension
        symlink_path = "#{POWPATH}/#{app_name}"
        if File.exists?(symlink_path)
          %x{open http://#{app_name}.#{ext}}
        else
          $stdout.puts "Powify could not find an app to browse with the name #{app_name}"
          Powify::Server.list
        end
      end
      alias_method :open, :browse
      
      def rename(args = [])
        return help if args.empty?
        original_app_name, new_app_name = File.basename(current_path), args[0].strip.to_s.downcase       
        original_app_name, new_app_name = args[0].strip.to_s.downcase, args[1].strip.to_s.downcase if args.size > 1
        original_symlink_path, new_symlink_path = "#{POWPATH}/#{original_app_name}", "#{POWPATH}/#{new_app_name}"
        
        FileUtils.rm(original_symlink_path)
        FileUtils.ln_s(current_path, new_symlink_path)
        
        $stdout.puts "Succesfully renamed #{original_app_name} to #{new_app_name}."
        $stdout.puts "Type `powify browse #{new_app_name}` to open the application in your browser."
      end
      
      def logs(args = [])
        app_name = args[0] ? args[0].strip.to_s.downcase : File.basename(current_path)
        system "tail -f #{POWPATH}/#{app_name}/log/development.log"
      end
      
      private
      def is_pow?
        return true if File.exists?('config.ru') || File.exists?('public/index.html')
       
        $stdout.puts "This does not appear to be a rack application (there is not config.ru)."
        $stdout.puts "If you are in a Rails 2 application, see the following: https://gist.github.com/909308"
        return false
      end
      
      def current_path
        %x{pwd}.strip
      end
      
      def extension
        if File.exists?('~/.powconfig')
          return %x{source ~/.powconfig; echo $POW_DOMAIN}.strip unless %x{source ~/.powconfig; echo $POW_DOMAIN}.strip.empty?
          return %x{source ~/.powconfig; echo $POW_DOMAINS}.strip.split(',').first unless %x{source ~/.powconfig; echo $POW_DOMAINS}.strip.empty?
        else
          return %x{echo $POW_DOMAIN}.strip unless %x{echo $POW_DOMAIN}.strip.empty?
          return %x{echo $POW_DOMAINS}.strip.split(',').first unless %x{echo $POW_DOMAINS}.strip.empty?
        end
        
        return 'dev'
      end
    end
  end
end