require 'rubygems'
require 'rake'
require 'rspec/core/rake_task'

desc 'Default: run specs.'
RSpec::Core::RakeTask.new(:spec)

task :build do
  %x{gem build zerigodns.gemspec}
end

task :doc do
  %x{yard doc}
end

task :default => :spec
task :default => :build
task :default => :doc


# require 'rdoc/task'
# RDoc::Task.new do |rdoc|
#   version = File.exist?('VERSION') ? File.read('VERSION') : ""
# 
#   rdoc.rdoc_dir = 'rdoc'
#   rdoc.title = "zerigo_dns #{version}"
#   rdoc.rdoc_files.include('README*')
#   rdoc.rdoc_files.include('lib/**/*.rb')
# end
