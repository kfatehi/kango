module Kango
  module Templates
    def self.gemfile
      <<-EOF
source 'https://rubygems.org'

gem 'kango', '~> #{Kango::VERSION}'
      EOF
    end

    def self.main_coffee
      <<-EOF
MyExtension = ->
  kango.ui.browserButton.addEventListener kango.ui.browserButton.event.COMMAND, =>
    @._onCommand()

MyExtension:: = _onCommand: ->
  kango.browser.tabs.create url: "http://kangoextensions.com/"

extension = new MyExtension()
      EOF
    end
  end
end