module Kango
  module Installer
    def self.run!
      if Kango::Framework.exists?
        puts "Framework exists! Will not re-install."
      else
        zipfile = File.expand_path(File.join("~", 'kango-framework.zip'))
        puts "Downloading Kango Framework to #{zipfile}..."
        require 'open-uri'
        File.open(zipfile, 'wb') do |file|
          open(Kango::Framework::URL, 'rb') do |download|
            file.write download.read
          end
        end
        puts "Download complete! Extracting..."
        `unzip #{zipfile} -d #{Kango::Framework::PATH}`
        if Kango::Framework.exists?
          FileUtils.rm zipfile
          puts "Kango Framework is ready. You can now 'kango build'"
        else
          puts "Something went wrong... probably could not download Kango Framework"
        end
      end
    end
  end
end