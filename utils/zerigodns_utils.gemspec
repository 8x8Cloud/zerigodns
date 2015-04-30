# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "zerigodns_utils"
  spec.version       = '0.0.1'
  spec.authors       = ["Raymond F. Wells"]
  spec.email         = ["rfw2nd@gmail.com"]
  spec.summary       = %q{ZerigoDNS commandline utilites.}
  spec.description   = %q{Small commandline utilities for managing zerigodns.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "zerigodns", "~> 1.1.0"
  
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
