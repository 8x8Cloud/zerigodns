# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "zerigo_dns"
  s.version = "1.5.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tom Wilson"]
  s.date = "2014-11-21"
  s.description = "This gem is a resource wrapper of the example provide by zerigo dns"
  s.email = "tom@jackhq.com"
  s.extra_rdoc_files = [
    "LICENSE"
  ]
  s.files = [
    "LICENSE",
    "Rakefile",
    "example/sample.rb",
    "lib/activeresource-ext.rb",
    "lib/zerigo_dns.rb"
  ]
  s.homepage = "http://github.com/twilson63/zerigo_dns"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.25"
  s.summary = "Zerigo DNS Gem"
  
  s.add_runtime_dependency %q<zerigo_dns>, ">= 0"
  s.add_development_dependency %q<thoughtbot-shoulda>, ">= 0"
  s.add_development_dependency %q<rake>, ">= 0"
  s.add_dependency %q<activeresource>, "~> 3.2.0"
  s.add_dependency 'yard', '~> 0.8.7.6'


end
