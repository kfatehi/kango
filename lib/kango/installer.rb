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
        require 'zip'
        puts "Download complete! Extracting..."
        begin
          Zip::File.open(zipfile) do |zip|
            zip.each do |zipentry|
              entryname = Kango::Framework::PATH + "/" + zipentry.to_s
              FileUtils.mkdir_p entryname.rpartition("/").first
              File.open(entryname, 'w') do |f|
                f.write zip.get_input_stream(zipentry).read
              end
            end
            zip.close
            puts "Extraction complete! Cleaning up..."
          end
        rescue Errno::EACCES => e
          puts "Permission denied. Ensure your home directory is writable."
          FileUtils.rm_f zipfile
          FileUtils.rm_rf Kango::Framework::PATH
          return
        end
        if Kango::Framework.exists?
          begin
            FileUtils.rm zipfile
          rescue Errno::EACCES => e
            puts "Permission denied when trying to delete download zip."
            puts "Remove #{zipfile} manually."
          end
          puts "Kango Framework is ready. You can now 'kango build'"
        else
          puts "Something went wrong... probably could not download Kango Framework"
        end
      end
    end
  end
end