module GreenButtonData
  module Fetchable
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      include Relations
      include Utilities

      def all(url = nil, options = nil)
        @url = url
        @options = options
        return records
      end

      def first(url = nil, options = nil)
        return all(url, options).first
      end

      def last(url = nil, options = nil)
        return all(url, options).last
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

          unless match_data.nil?
            id = match_data[3] || entry.id

            entry_content = case match_data[1]

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
              entry.content.usage_point
            else
              nil
            end

            yield id, entry_content, entry
          end
        end
      end

      def populate_model(feed)
        models = GreenButtonData::ModelCollection.new

        each_entry_content feed do |id, content, entry|
          attributes_hash = attributes_to_hash(content)
          attributes_hash[:id] = id

          related_urls = construct_related_urls entry
          p attributes_hash.merge(related_urls)

          models << self.new(attributes_hash)
        end

        return models
      end
    end # ClassMethods
  end # Fetchable
end # GreenButtonData
