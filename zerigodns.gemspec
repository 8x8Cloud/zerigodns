# -*- coding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "zerigodns"
  s.version = '1.0.0'

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  
  s.authors = ["Tom Wilson", "Zerigo Team"]
  s.date = "2014-11-21"
  s.description = "Gem for interacting with the Zerigo DNS REST API."
  s.email = "support@zerigo.com"
  
  s.extra_rdoc_files = [
    "LICENSE"
  ]

  s.files = %w(LICENSE Rakefile) + Dir.glob('lib/**/*.rb')

  s.homepage = "http://github.com/8x8Cloud/zerigo_dns"
  s.require_paths = %w(lib)
  s.rubygems_version = "1.8.25"
  s.summary = "Zerigo DNS Gem"
  
  s.add_dependency 'activeresource', "~> 3.2.0"

  s.add_development_dependency 'yard', '~> 0.8.7.6'  
  s.add_development_dependency 'rspec', '~> 2.99'
  s.add_development_dependency 'rake', ">= 0"
  s.add_development_dependency 'simplecov', '~> 0.9.1'
  
  s.add_runtime_dependency 'zerigodns', ">= 0"
end
