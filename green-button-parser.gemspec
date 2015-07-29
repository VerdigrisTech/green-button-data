require File.expand_path('../lib/green-button-data/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'green-button-data'
  s.version     = GreenButtonData::VERSION

  s.authors     = ['Andrew Jo']
  s.email       = 'engineering@verdigris.co'
  s.homepage    = 'http://verdigris.co'

  s.summary     = 'Parser for Green Button data format'
  s.description = 'A library to parse large Green Button feed quickly'

  s.files         = `git ls-files`.split("\n")
  s.require_paths = ['lib']

  s.platform    = Gem::Platform::RUBY

  s.add_dependency 'sax-machine', '~> 1.3'
  s.add_dependency 'ox', '~> 2.2'
end
