require 'rake'
require 'rspec/core/rake_task'


RSpec::Core::RakeTask.new(:test) do |spec|
  spec.pattern = 'spec/unit/*.rb'
  spec.rspec_opts = ['--backtrace']
end

task :default => [:test]

task :web do 
  ruby './start.rb'
end
