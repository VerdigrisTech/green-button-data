module GreenButtonData
  module Fetchable
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def all(url = nil, options = nil)
        @url = url
        @options = options
        return records
      end

      def first(url = nil, options = nil)
        @url = url
        @options = options
        return records.first
      end

      def last(url = nil, options = nil)
        @url = url
        @options = options
        return records.last
      end

      def fetch(url = nil, options = nil)
        url or raise ArgumentError.new "url is required to fetch data"

        connection_options = {}

        options ||= {}
        connection_options[:ssl] = options[:client_ssl] if options[:client_ssl]

        conn = Faraday.new connection_options
        conn.token_auth(options[:token]) if options[:token]

        response = conn.get url
        response.status == 200 and GreenButtonData::Feed.parse response.body
      end

      def feed
        @feed ||= fetch url, options
      end

      def records
        @records ||= populate_model(feed)
      end

      def options
        @options
      end

      def url
        @url
      end

      private

      def each_entry_content(feed)
        entry_content = nil

        feed.entries.each do |entry|
          match_data = /\/(\w+)(\/(\d+))*$/.match(entry.self.downcase)

          entry_content = unless match_data.nil?
            case match_data[1]
            when 'applicationinformation'
              entry.content.application_information
            when 'authorization'
              entry.content.authorization
            when 'intervalblock'
              entry.content.interval_block
            when 'localtimeparameters'
              entry.content.local_time_parameters
            when 'readingtype'
              entry.content.reading_type
            when 'usagepoint'
              entry.usage_point
            else
              nil
            end
          end

          yield entry_content
        end
      end

      def populate_model(feed)
        models = GreenButtonData::ModelCollection.new

        each_entry_content feed do |content|
          models << self.new(content)
        end

        return models
      end
    end # ClassMethods
  end # Fetchable
end # GreenButtonData
