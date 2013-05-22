require 'coffee-script'

module Kango  
  class ScriptCompiler
    def initialize dir_glob, extension, compiler
      @compiler = compiler
      @extension = extension
      @files = Dir.glob("#{dir_glob}.#{extension}")
    end

    def script_regex
      /(^#{@extension}|#{@extension}$)/
    end

    def compile
      @files.each do |file|
        script = file.gsub(script_regex, 'js').split('/').last
        path = File.join('src', 'common', script)
        puts "[   INFO] Compiling #{file} to #{path.to_s}"
        FileUtils.mkdir_p File.dirname(path)
        File.open(path.to_s, 'w') do |f|
          if @compiler.to_s == 'CoffeeScript'
            f.puts Kango::ScriptCompiler.coffee_userscript_commentblock file
          end
          f.puts Kango::ScriptCompiler.compile file, with: @compiler
        end
      end
    end

    ##
    # Compile the script to javascript
    def self.compile file, options
      compiler = options[:with]
      compiler.compile File.read(file), :bare => true
    end

    ##
    # Extract userscript comment block from CoffeeScript file.
    def self.coffee_userscript_commentblock(coffee_file)
      comment = ""
      File.open(coffee_file) do |f|
        while line = f.gets
          break unless line =~ /^#/
          comment += line.gsub(/^#/, '//')
        end
      end
      comment
    end
  end
end