module Kango
  def self.install!
    zipfile = File.expand_path(File.join("~", 'kango-framework.zip'))
    puts "Downloading Kango Framework to #{zipfile}..."
    require 'open-uri'
    File.open(zipfile, 'wb') do |file|
      open(KANGO_FRAMEWORK_URL, 'rb') do |download|
        file.write download.read
      end
    end
    puts "Download complete! Extracting..."
    `unzip #{zipfile} -d #{KANGO_FRAMEWORK}`
    if Kango.framework_exists?
      FileUtils.rm zipfile
      puts "Kango Framework is ready. You can now rake build"
    else
      puts "Something went wrong... probably could not download Kango Framework"
    end
  end
end