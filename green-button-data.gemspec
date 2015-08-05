require File.expand_path('../lib/green-button-data/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'green-button-data'
  s.version     = GreenButtonData::VERSION

  s.authors     = ['Andrew Jo']
  s.email       = 'engineering@verdigris.co'
  s.homepage    = 'http://verdigris.co'
  s.licenses    = ['BSD-2-Clause']

  s.summary     = 'Parser for Green Button data format'
  s.description = 'A library to parse large Green Button feed quickly'

  s.files         = `git ls-files`.split("\n")
  s.require_paths = ['lib']

  s.platform              = Gem::Platform::RUBY
  s.required_ruby_version = '>= 1.9.3'

  s.add_dependency 'nokogiri', '~> 1.6'
  s.add_dependency 'sax-machine', '~> 1.3'
  s.add_dependency 'faraday', '~> 0.9'

  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'webmock', '~> 1.21'
  s.add_development_dependency 'guard', '~>2.13'
end
