require File.expand_path(File.dirname(__FILE__) + '/../lib/green-button-data')
require 'fixtures'
require 'simplecov'

SimpleCov.start
if ENV['CI'] == 'true'
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

SAXMachine.handler = ENV['HANDLER'].to_sym if ENV['HANDLER']

RSpec.configure do |c|
  c.include Fixtures
end
