# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'all_seeing_pi/version'

Gem::Specification.new do |spec|
  spec.name          = "all_seeing_pi"
  spec.version       = AllSeeingPi::VERSION
  spec.authors       = ["Jonan Scheffler"]
  spec.email         = ["jonanscheffler@gmail.com"]
  spec.summary       = %q{A gem to capture images with a Raspberry Pi camera.}
  spec.description   = %q{The one gem to rule homemade Raspberry Pi surveillance systems. This gem will capture images one after another and upload them to an S3 bucket.}
  spec.homepage      = "http://github.com/1337807/all_seeing_pi"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "mocha"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  spec.add_runtime_dependency "aws-sdk"
  spec.add_runtime_dependency "phashion"
end
