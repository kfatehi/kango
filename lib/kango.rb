require "kango/version"
require 'thor'

module Kango
  KANGO_FRAMEWORK_URL = "http://kangoextensions.com/kango/kango-framework-latest.zip"
  KANGO_FRAMEWORK = File.expand_path(File.join('~', 'kango-framework'))

  def self.framework_exists?
    File.directory? KANGO_FRAMEWORK
  end
  
  class Tasks < Thor    
    desc "install", "Install the kango framework"
    def install
      require 'kango/install'
      if Kango.framework_exists?
        puts "Framework exists! Will not re-install."
      else
        Kango.install!
      end
    end

    desc 'compile', 'Compile coffeescript userscripts into common as javascript'
    def compile
      require 'coffee-script'
      Dir.glob('coffee/**/*.coffee') do |file|
        script = file.gsub(/(^coffee|coffee$)/, 'js').split('/').last
        path = Pathname.new('src/common').join(script)
        puts "[   INFO] Compiling #{file} to #{path.to_s}"
        FileUtils.mkdir_p path.dirname
        File.open(path.to_s, 'w') do |f|
          f.puts userscript_commentblock(file)
          f.puts CoffeeScript.compile File.read(file), :bare => true
        end
      end
    end

    desc 'build', 'Build the extensions with Kango'
    def build
      self.compile
      ensure_framework do
        `python #{KANGO_FRAMEWORK}/kango.py build .`
      end
    end

    desc 'create', 'Create a new kango project'
    def create name
      require 'kango/templates'
      ensure_framework do
        path = File.expand_path(File.join(Dir.pwd, name))
        puts "Creating Kango project at #{path}"
        `echo #{name} | python #{KANGO_FRAMEWORK}/kango.py create #{path}`
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

    private

    ##
    # Extract userscript comment block from CoffeeScript file.
    def userscript_commentblock(coffee_file)
      comment = ""
      File.open(coffee_file) do |f|
        while line = f.gets
          break unless line =~ /^#/
          comment += line.gsub(/^#/, '//')
        end
      end
      comment
    end

    ##
    # Calls the block only if the framework exists
    def ensure_framework &block
      if Kango.framework_exists?
        block.call
      else
        puts "Kango Framework is missing. Install it with 'kango install'"
      end
    end
  end
end
