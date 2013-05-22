require "kango/version"
require 'kango/tasks'

module Kango
  module Framework
    URL = "http://kangoextensions.com/kango/kango-framework-latest.zip"
    PATH = File.expand_path(File.join('~', 'kango-framework'))

    def self.exists?
      File.directory? Kango::Framework::PATH
    end

    def self.build!
      `python #{Kango::Framework::PATH}/kango.py build .`
    end

    def self.create_project! name, path
      `echo #{name} | python #{Kango::Framework::PATH}/kango.py create #{path}`
    end
  end
end
