# Green Button Data

[![CI Results](https://img.shields.io/circleci/project/VerdigrisTech/green-button-data.svg)](https://circleci.com/gh/VerdigrisTech/green-button-data)
[![Dependencies](https://img.shields.io/gemnasium/VerdigrisTech/green-button-data.svg)](https://gemnasium.com/VerdigrisTech/green-button-data)
[![Code Coverage](https://img.shields.io/codecov/c/github/VerdigrisTech/green-button-data.svg)](https://codecov.io/github/VerdigrisTech/green-button-data)
[![Code Climate](https://img.shields.io/codeclimate/github/VerdigrisTech/green-button-data.svg)](https://codeclimate.com/github/VerdigrisTech/green-button-data)

Green Button Data is a Ruby gem that can quickly parse the Green Button data
standard. It uses an event-driven <abbr title="Simple API for XML">SAX</abbr>
parser which does not build the entire <abbr title="Document Object Model">DOM</abbr>
in memory.

## Getting Started

Add the Green Button Data gem to your Gemfile:

```ruby
gem 'green-button-data'
```

Then run Bundler:

```bash
$ bundle
```

## Usage

Almost all of the functionality for parsing data is wrapped in the
`GreenButtonData::Feed` class.

To parse a Green Button Atom feed, simply call the `parse` method and pass in
the entire XML document:

```ruby
require 'green-button-data'

xml_text = File.read "#{File.dirname __FILE__}/gb_example_interval_block.xml"
data = GreenButtonData::Feed.parse xml_text
```

You can then access the data like this:

```ruby
# Print all the interval readings from the feed
data.entries.each do |entry|
  p "Entry: #{entry.title}"
  entry.content.interval_block.interval_readings.each do |reading|
    time_period = reading.time_period
    p "[#{time_period.starts_at} - #{time_period.ends_at}]: #{reading.value}"
  end
end
```

## Contributing

1. Fork this project
2. Create a feature branch: `git checkout -b my-awesome-feature`
3. Make changes and commit: `git commit -am "Add awesome feature"`
4. Push the branch: `git push origin my-awesome-feature`
5. Submit a pull request

## License

This software is distributed AS IS WITHOUT WARRANTY under [Simplified BSD](https://raw.githubusercontent.com/VerdigrisTech/green-button-data/master/LICENSE.txt)
license.

Verdigris Technologies Inc. assumes NO RESPONSIBILITY OR LIABILITY
UNDER ANY CIRCUMSTANCES for usage of this software. See the [LICENSE.txt](https://raw.githubusercontent.com/VerdigrisTech/green-button-data/master/LICENSE.txt)
file for detailed legal information.

Copyright © 2015, Verdigris Technologies Inc. All rights reserved.
