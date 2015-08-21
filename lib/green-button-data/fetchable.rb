require 'uri'

module GreenButtonData
  module Fetchable
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      include Relations
      include Utilities

      ##
      # Returns all entries
      #
      # ==== Arguments
      #
      # * +url+ (OPTIONAL) - URL to fetch from. If not supplied, it defaults to
      #                      the URLs in configuration.
      # * +options+ - Options hash
      def all(url = nil, options = nil)
        if url.is_a?(Hash)
          # Assume it is an options Hash
          options = url
          url = GreenButtonData.configuration
                               .send("#{class_name.underscore}_url")
        end

        @url = url
        @options = options
        return records
      end

      ##
      # Returns the first item in the ModelCollection from all entries returned
      # by the API endpoint
      #
      # ==== Arguments
      #
      # * +url+ (OPTIONAL) - URL to fetch from. If not supplied, it defaults to
      #                      the URLs in configuration.
      # * +options+ - Options hash
      def first(url = nil, options = nil)
        return all(url, options).first
      end

      ##
      # Finds an entry that matches the {id} in the URL of the form:
      # https://services.greenbuttondata.org/DataCustodian/espi/1_1/resource/{model_name}/{id}
      #
      # ==== Arguments
      #
      # * +id+ - ID of the entry content. URL matching a single entry content
      #          can be supplied in place of ID.
      # * +url+ (OPTIONAL) - If specified, this URL is used to fetch data in
      #                      place of global configuration.
      # * +options+ - Options hash
      #
      # ==== Examples
      #
      # The following fetches data identically.
      #
      # ReadingType.find(1, token: "12345678-1024-2048-abcdef001234") # use global config
      # ReadingType.find("https://services.greenbuttondata.org/DataCustodian/espi/1_1/resource/ReadingType/1", token: "12345678-1024-2048-abcdef001234") # override global config and use specific url
      def find(id = nil, options = nil)
        # If +id+ argument is a URL, set the url
        url = if id =~ /\A#{URI::regexp}\z/
          id
        else
          path_prefix = GreenButtonData.configuration
                                       .send("#{class_name.underscore}_url")
          "#{path_prefix}/#{id}"
        end

        return populate_models(fetch(url, options)).first
      end

      def last(url = nil, options = nil)
        return all(url, options).last
      end

      def fetch(url = nil, options = nil)
        url or raise ArgumentError.new "url is required to fetch data"

        connection_options = {}

        options ||= {}
        connection_options[:ssl] = options[:ssl] if options[:ssl]

        conn = Faraday.new connection_options
        conn.authorization :Bearer, options[:token] if options[:token]

        response = conn.get url
        if response.status == 200
          GreenButtonData::Feed.parse response.body
        else
          raise "Status: #{response.status}"
        end
      end

      def feed
        @feed ||= fetch url, options
      end

      def records
        @records ||= populate_models(feed)
      end

      def options
        @options
      end

      def url
        @url
      end

      private

      def class_name
        self.name.split('::').last
      end

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
            when 'electricpowerusagesummary'
              entry.content.electric_power_usage_summary
            when 'intervalblock'
              entry.content.interval_block
            when 'localtimeparameters'
              entry.content.local_time_parameters
            when 'readingtype'
              entry.content.reading_type
            when 'usagepoint'
              entry.content.usage_point
            when 'usagesummary'
              entry.content.usage_summary
            else
              nil
            end

            yield id, entry_content, entry
          end
        end
      end

      def populate_models(feed)
        models = GreenButtonData::ModelCollection.new

        each_entry_content feed do |id, content, entry|
          attributes_hash = attributes_to_hash(content)
          attributes_hash[:id] = id

          attributes_hash[:related_urls] = construct_related_urls entry
          models << self.new(attributes_hash)
        end

        return models
      end
    end # ClassMethods
  end # Fetchable
end # GreenButtonData
