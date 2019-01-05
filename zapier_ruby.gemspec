# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zapier_ruby/version'

Gem::Specification.new do |spec|
  spec.name          = "zapier_ruby"
  spec.version       = ZapierRuby::VERSION
  spec.authors       = ["David Peterson"]
  spec.email         = ["pete2786@umn.edu"]
  spec.summary       = %q{Simple gem to integrate Zapier webhooks with a Ruby project.}
  spec.description   = %q{Simple gem to integrate Zapier webhooks with a Ruby project.}
  spec.homepage      = "http://pete2786.github.io"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rest-client"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "pry"
end
