# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'reserved_word/version'

Gem::Specification.new do |spec|
  spec.name          = "reserved_word"
  spec.version       = ReservedWord::VERSION
  spec.authors       = ["rono23"]
  spec.email         = ["rono23@gmail.com"]
  spec.description   = %q{Make your reserved words on Rails}
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/rono23/reserved_word"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_dependency "rails", ">= 3.2.13"
end
