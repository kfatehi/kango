module Kango
  module Reloader
    module Chrome
      class ExtensionsReloader
        attr_accessor :watch_folder, :watcher, :on

        def initialize
          self.watch_folder = File.join(Dir.pwd, 'output', 'chrome')
          STDOUT.puts "#{self.class} watching #{self.watch_folder}"
          STDOUT.puts "WARNING: This experimental feature requires the chrome extension called ExtensionsReloader and calls the following command: #{command}"
        end

        def trigger &block
          return if @on
          self.watcher = DirectoryWatcher.new(self.watch_folder, :pre_load => true)
          self.watcher.interval = 1
          self.watcher.add_observer do |*args|
            block.call
          end
          self.watcher.start
          self.on = true
        end

        def command
          %{open -a '/Applications/Google\ Chrome\ Canary.app' 'http://reload.extensions'}
        end

        def reload_browser
          system(command)
        end
      end
    end
  end
end
