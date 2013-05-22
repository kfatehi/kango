require "kango/version"
require 'kango/tasks'

module Kango
  KANGO_FRAMEWORK_URL = "http://kangoextensions.com/kango/kango-framework-latest.zip"
  KANGO_FRAMEWORK = File.expand_path(File.join('~', 'kango-framework'))

  def self.framework_exists?
    File.directory? KANGO_FRAMEWORK
  end
end
