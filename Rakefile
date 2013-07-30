require 'rake'
require "rspec/core/rake_task"


RSpec::Core::RakeTask.new(:test) do |spec|
  spec.pattern = 'spec/unit/*.rb'
  spec.rspec_opts = ['--backtrace --failure-exit-code 0']
end

task :default => [:server]

task :server do 
  ruby "./start.rb"
end
