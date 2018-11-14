task default: %w[rubocop spec 20180312]

desc 'get data for 20180312'
task '20180312' do
  ruby 'incident_documentation.rb 20180312'
end

require 'rubocop/rake_task'
RuboCop::RakeTask.new

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
