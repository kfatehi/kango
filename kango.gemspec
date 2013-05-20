# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kango/version'

Gem::Specification.new do |spec|
  spec.name          = "kango"
  spec.version       = Kango::VERSION
  spec.authors       = ["Keyvan Fatehi"]
  spec.email         = ["keyvanfatehi@gmail.com"]
  spec.description   = %q{Wraps the brilliant Kango Framework with ruby niceties}
  spec.summary       = %q{Write browser extensions with Kango & Coffeescript}
  spec.homepage      = "https://github.com/keyvanfatehi/kango"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  
  spec.add_runtime_dependency 'thor', '~>0.18.1'
  spec.add_runtime_dependency 'coffee-script', '~> 2.2.0'
  spec.add_runtime_dependency 'launchy'
end
