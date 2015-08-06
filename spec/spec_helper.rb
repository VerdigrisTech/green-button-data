require 'simplecov'

SimpleCov.start do
  add_filter "/spec/"
end

if ENV['CI'] == 'true'
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

require File.expand_path(File.dirname(__FILE__) + '/../lib/green-button-data')
require 'webmock/rspec'
require 'fixtures'
require 'support/custom_expectations/warn_expectation'

# Disable network connections
WebMock.disable_net_connect! allow_localhost: true

SAXMachine.handler = ENV['HANDLER'].to_sym if ENV['HANDLER']

RSpec.configure do |c|
  c.include Fixtures
end
