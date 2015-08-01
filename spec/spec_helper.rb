require File.expand_path(File.dirname(__FILE__) + '/../lib/green-button-data')
require 'fixtures'

SAXMachine.handler = ENV['HANDLER'].to_sym if ENV['HANDLER']

RSpec.configure do |c|
  c.include Fixtures
end
