require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :benchmark do
  ruby "benchmark/run.rb"
end

task default: :spec
