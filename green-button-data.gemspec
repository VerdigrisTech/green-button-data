require File.expand_path('../lib/green-button-data/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'green-button-data'
  s.version     = GreenButtonData::VERSION

  s.authors     = ['Andrew Jo', 'Orlando Lee', 'Edward Breen']
  s.email       = 'engineering@verdigris.co'
  s.homepage    = 'http://verdigris.co'
  s.licenses    = ['BSD-2-Clause']

  s.summary     = 'Client and parser for Green Button API'
  s.description = 'Green Button Data is a Ruby gem that can consume Green ' +
                  'Button APIs and parse the Green Button data XML schema ' +
                  'very quickly. It uses an event-driven SAX parser which ' +
                  'parses XML data without building an entire DOM in memory.'

  s.files         = `git ls-files`.split("\n").reject {
    |f| f.match(%r{^(test|spec|fixtures|benchmark)/})
  }

  s.require_paths = ['lib']

  s.platform              = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.6.0'

  s.add_dependency 'nokogiri', '~> 1.8'
  s.add_dependency 'sax-machine', '~> 1.3'
  s.add_dependency 'faraday', '~> 1.0'

  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'webmock', '~> 2.3'
  s.add_development_dependency 'guard', '~>2.13'
end
