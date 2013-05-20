require 'spec_helper'

describe Kango::Generator do
  let(:generator) { Kango::Generator.new(PROJECT_DIR) }
  describe "generate!" do
    it "generates a new Kango project" do
      generator.generate!
      binding.pry
    end
  end
end