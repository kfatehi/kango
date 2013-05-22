require 'thor'

module Kango
  class Tasks < Thor
    desc "install", "Install the kango framework"
    def install
      require 'kango/installer'
      Kango::Installer.run!
    end

    desc 'compile', 'Compile coffeescript userscripts into common as javascript'
    def compile
      require 'kango/script_compiler'
      Kango::ScriptCompiler.new('coffee/**/*', 'coffee', CoffeeScript).compile
    end

    desc 'build', 'Build the extensions with Kango'
    def build
      ensure_framework do
        self.compile if File.directory?(File.join(Dir.pwd, 'coffee'))
        Kango::Framework.build!
      end
    end

    desc 'create', 'Create a new kango project'
    def create name
      require 'kango/templates'
      ensure_framework do
        path = File.expand_path(File.join(Dir.pwd, name))
        puts "Creating Kango project at #{path}"
        Kango::Framework.create_project! name, path
        File.open(File.join(path, 'Gemfile'), 'w') do |gemfile|
          gemfile.puts Kango::Templates.gemfile
        end
        FileUtils.mkdir File.join(path, 'coffee')
        File.open(File.join(path, 'coffee', 'main.coffee'), 'w') do |main|
          main.puts Kango::Templates.main_coffee
        end
      end
    end

    desc 'docs', 'Open Kango Framework documentation'
    def docs
      require 'launchy'
      Launchy.open("http://kangoextensions.com/docs/index.html")
    end

    desc 'watch', 'Watch for changes and build automatically'
    def watch *opts
      ensure_framework do
        require 'directory_watcher'

        if opts.include? 'reload.extensions'
          require 'kango/reloader/chrome/extensions_reloader'
          @reloader = Kango::Reloader::Chrome::ExtensionsReloader.new
        end

        coffee = DirectoryWatcher.new(File.join(Dir.pwd,'coffee'), globs:'**/*.coffee', :pre_load => true)
        coffee.interval = 1
        coffee.add_observer do |*args|
          self.compile
        end
        coffee.start

        common = DirectoryWatcher.new(File.join(Dir.pwd,'src','common'), :pre_load => true)
        common.interval = 1
        common.add_observer do |*args|
          Kango::Framework.build!
        end
        common.start

        if @reloader
          @reloader.trigger do
            @reloader.reload_browser
          end
        end

        unless options['serving']
          trap("INT") do
            puts "     Halting auto-regeneration."
            exit 0
          end

          loop { sleep 1000 }
        end
      end
    end

    private

    ##
    # Calls the block only if the framework exists
    def ensure_framework &block
      if Kango::Framework.exists?
        block.call
      else
        puts "Kango Framework is missing. Install it with 'kango install'"
      end
    end
  end
end