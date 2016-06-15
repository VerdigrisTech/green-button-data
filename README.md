# Green Button Data

[![Gem Version](https://img.shields.io/gem/v/green-button-data.svg)](https://rubygems.org/gems/green-button-data)
[![CI Results](https://img.shields.io/circleci/project/VerdigrisTech/green-button-data.svg)](https://circleci.com/gh/VerdigrisTech/green-button-data)
[![Dependencies](https://img.shields.io/gemnasium/VerdigrisTech/green-button-data.svg)](https://gemnasium.com/VerdigrisTech/green-button-data)
[![Code Climate](https://img.shields.io/codeclimate/github/VerdigrisTech/green-button-data.svg)](https://codeclimate.com/github/VerdigrisTech/green-button-data)
[![Code Coverage](https://img.shields.io/codecov/c/github/VerdigrisTech/green-button-data.svg)](https://codecov.io/github/VerdigrisTech/green-button-data)

Green Button Data is a Ruby gem that can consume Green Button APIs and parse
the Green Button data XML schema very quickly. It uses an event-driven
<abbr title="Simple API for XML">SAX</abbr> parser which parses XML data without
building an entire <abbr title="Document Object Model">DOM</abbr> in memory.

On a 2.3 GHz Core i7 processor, this gem is capable of parsing at a rate of
~1.7 MB/s which is fast enough to parse a 1 year 12-hour interval data in just
over a second.

You may run the benchmarks by cloning this project and running `rake benchmark`.

## Getting Started

Add the Green Button Data gem to your Gemfile:

```ruby
gem 'green-button-data'
```

Then run Bundler:

```bash
$ bundle
```

Unless you have a project that auto loads all gems in the Gemfile (e.g. a Rails
project), you will need to require it:

```ruby
require 'green-button-data'
```

This will expose the GreenButtonData module namespace.

## Integrating GreenButtonData Into Your Application

GreenButtonData gem provides a familiar interface to consuming API endpoints.
Method names are similar to Rails' ActiveRecord models and can be easily
integrated into existing applications.

### Global Configuration

You can add configuration options like the following:

```ruby
GreenButtonData.configure do |config|
  config.base_url = "https://api.example.com/DataCustodian/espi/1_1/resource/"
  config.application_information_path = "ApplicationInformation/"
  config.authorization_path = "Authorization/"
  config.subscription_path = "Subscription/"
  config.usage_point_path = "UsagePoint/"
end
```

Note that each path _must_ end with a trailing slash.

#### Rails Integration

> **IMPORTANT:** Version 0.3.0 has a bug which causes Rails not to boot
correctly. Please use 0.3.1 or higher when integrating into Rails by
running `bundle update green-button-data`.

If you are developing a Rails app, create a file at
`config/initializers/green_button_data.rb` from your Rails project root and
add the configuration there.

## Green Button Data API Client

Green Button Data specification states that all API endpoints be secured with
OAuth2 which means most fetch operations will require auth tokens.

Some endpoints are secured further by utilizing client SSL certificates (e.g.
Pacific Gas & Electric). You may pass in `ssl` options in addition to
the `token` option in this case.

> **DISCLAIMER:** Green Button Data is **_NOT_** responsible for managing OAuth
tokens to make authenticated requests. There are other gems that provide mature,
production proven OAuth 2 functionalities such as [OmniAuth](https://github.com/intridea/omniauth).

### Querying Data

With version 0.4.0, there are two ways to query data on a remote endpoint:

* Using a scoped client class
* Calling query methods directly on resource classes

#### Using API Client class

This is the recommended method to query data from multiple
[Data Custodians](http://greenbuttondata.org/developers/).

Each instance of `GreenButtonData::Client` uses scoped configuration suitable
for each Data Custodians.

This allows you to make requests to different Data Custodians that have
different URL path layouts.

The example below creates two clients: one for
ESPI Green Button Data reference API and the other for Pacific Gas & Electric:

```ruby
espi_base_url   = "https://services.greenbuttondata.org/DataCustodian/espi/" +
                  "1_1/resource/"
pge_base_url    = "https://api.pge.com/GreenButtonConnect/espi/1_1/resource/"

espi_client = GreenButtonData.connect base_url: "https://foo.com" do |client|
  # Override base_url configuration
  client.configuration.base_url = espi_base_url

  # Equivalent to passing in as an argument hash in connect method:
  # GreenButtonData.connect subscription_path: "Subscription/" do |client|
  client.configuration.subscription_path = "Subscription/"

  client.configuration.usage_point_path = "UsagePoint/"
  client.configuration.usage_summary_path = "ElectricPowerUsageSummary/"

  # Set OAuth 2.0 bearer token
  client.token = "12345678-5672-abcd-567890abcdef"
end

pge_client = GreenButtonData.connect base_url: pge_base_url do |client|
  client.configuration.subscription_path = "Subscription/"
  client.configuration.usage_point_path = "UsagePoint/"
  client.configuration.usage_summary_path = "UsageSummary/"

  client.token = "098765432-abcd-ef00-12345678900"
end
```

##### Querying a resource

The `Client` class provides query methods to query each resources:

* `GreenButtonData::Client#application_information`

  Returns a collection of `GreenButtonData::ApplicationInformation` instances if
  id is not specified. If id is specified, returns a single instance.

* `GreenButtonData::Client#authorization`

  Returns a collection of `GreenButtonData::Authorization` instances if id is
  not specified. If id is specified, returns a single instance.

* `GreenButtonData::Client#interval_block`

  Returns a collection of `GreenButtonData::IntervalBlock` instances if id is
  not specified. If id is specified, returns a single instance.

* `GreenButtonData::Client#local_time_parameters`

  Returns a collection of `GreenButtonData::LocalTimeParameters` instances if id
  is not specified. If id is specified, returns a single instance.

* `GreenButtonData::Client#meter_reading`

  Returns a collection of `GreenButtonData::MeterReading` instances if id is not
  specified. If id is specified, returns a single instance.

* `GreenButtonData::Client#reading_type`

  Returns a collection of `GreenButtonData::ReadingType` instances if id is not
  specified. If id is specified, returns a single instance.

* `GreenButtonData::Client#usage_point`

  Returns a collection of `GreenButtonData::UsagePoint` instances if id is not
  specified. If id is specified, returns a single instance.

* `GreenButtonData::Client#usage_summary`

  Returns a collection of `GreenButtonData::UsageSummary` instances if id is not
  specified. If id is specified, returns a single instance.

Following the example from previous section, to retrieve all entries:

```ruby
# Generally, Data Custodian access token is required to do this query which you
# can override with `token` keyword argument
# Makes a request to:
# https://services.greenbuttondata.org/DataCustodian/espi/1_1/resources/UsagePoint
espi_all_usage_points = espi_client.usage_point
```

To retrieve a specific entry, specify the resource ID:

```ruby
# Get a Usage Point 2
# Makes a request to:
# https://services.greenbuttondata.org/DataCustodian/espi/1_1/resources/UsagePoint/2
espi_usage_point = espi_client.usage_point 2, token: data_custodian_access_token

# Get a UsagePoint 1234 for subscription 3401
# Makes a request to:
# https://api.pge.com/GreenButtonConnect/espi/1_1/resources/Subscription/3401/UsagePoint/1234
pge_usage_point = pge_client.usage_point 1234, subscription_id: 3401
```

You can query for related resources as well. There are couple ways you can do
this:

```ruby
# Gets all meter readings for this instance of UsagePoint
meter_readings_1 = pge_usage_point.meter_readings

# Same as above but requires knowledge of UsagePoint and Subscription ids
meter_readings_2 = pge_client.meter_reading usage_point_id: 1234, subscription_id: 3401
```

#### Using resource classes

This method allows you to query for data using the global configuration. This
has limitations as you can only query data from one Data Custodian at a time
unless you override the global configuration per method call.

The resource classes are as follows:

* `GreenButtonData::ApplicationInformation`
* `GreenButtonData::Authorization`
* `GreenButtonData::IntervalBlock`
* `GreenButtonData::LocalTimeParameters`
* `GreenButtonData::MeterReading`
* `GreenButtonData::ReadingType`
* `GreenButtonData::UsagePoint`
* `GreenButtonData::UsageSummary`

##### List all entries

By default, the `.all` method attempts to use the URL path set by configuration:

```ruby
require 'green-button-data'

# Ideally obtained from OmniAuth gem
access_token = "12345678-1024-2048-abcdef001234"

# Return all usage points; URL is specified in GreenButtonData.configuration.usage_point_url
usage_points = UsagePoint.all token: access_token
```

You may override the global configuration by specifying the URL in the method:

```ruby
usage_points = UsagePoint.all "https://someotherapi.org/espi/Authorization",
                              token: access_token
```

##### Find an entry by ID

If you have URL defined in configuration, the `.find` method appends the ID to
the URL:

```ruby
GreenButtonData.configure do |config|
  config.base_url = "https://services.greenbuttondata.org/"
  config.usage_point_path = "DataCustodian/espi/1_1/resource/UsagePoint/"
end

# GET request to https://services.greenbuttondata.org/DataCustodian/espi/1_1/resource/UsagePoint/2
usage_point = GreenButtonData::UsagePoint.find 2, token: access_token
```

As with `.all` method, URL can be overridden per request in `.find`:

```ruby
usage_point = GreenButtonData::UsagePoint.find "https://someotherapi.org/espi/UsagePoint/1",
                                               token: access_token
```

## Parsing

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

## Versioning

Green Button Data gem follows [Semantic Versioning 2.0](http://semver.org/). As
such, you can specify a pessimistic version constraint on this gem with two
digits of precision and be guaranteed latest features and bug fixes without
backwards breaking changes:

```ruby
gem 'green-button-data', '~> 0.1'
```

Exception to this rule as per the SemVer specification is major version zero for
initial development. This gem's API should NOT be considered stable until 1.0
release.

## License

This software is distributed AS IS WITHOUT WARRANTY under [Simplified BSD](https://raw.githubusercontent.com/VerdigrisTech/green-button-data/master/LICENSE.txt)
license.

Verdigris Technologies Inc. assumes NO RESPONSIBILITY OR LIABILITY
UNDER ANY CIRCUMSTANCES for usage of this software. See the [LICENSE.txt](https://raw.githubusercontent.com/VerdigrisTech/green-button-data/master/LICENSE.txt)
file for detailed legal information.

Copyright © 2015, [Verdigris Technologies Inc](http://verdigris.co). All rights reserved.
