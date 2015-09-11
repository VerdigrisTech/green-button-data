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
          url = nil
        end

        url_options = url_options(options)

        url ||= if url_options.keys.size > 0
          GreenButtonData.configuration.send(
            "#{class_name.underscore}_url", url_options(options)
          )
        else
          GreenButtonData.configuration.send "#{class_name.underscore}_url"
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
          url_options = url_options options

          path_prefix = if url_options.keys.size > 0
            GreenButtonData.configuration.send(
              "#{class_name.underscore}_url", url_options(options)
            )
          else
            GreenButtonData.configuration.send "#{class_name.underscore}_url"
          end

          URI.join(path_prefix, "#{id}/").to_s
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

        conn = Faraday.new connection_options do |connection|
          connection.response :logger
          connection.adapter Faraday.default_adapter
        end
        conn.authorization :Bearer, options[:token] if options[:token]

        response = conn.get do |req|
          req.url url
          req.params = build_query_params options
        end

        if response.status == 200
          GreenButtonData::Feed.parse response.body
        elsif response.status == 401
          raise "Unauthorized API call; check authorization token and try again"
        elsif response.status == 500
          raise "500 Server Error:\n#{response.body}"
        else
          raise "Status: #{response.status}"
        end
      end

      def feed
        if !options[:reload] && @feed
          @feed
        else
          @feed = fetch url, options
        end
      end

      def records
        if !options[:reload] && @records
          @records
        else
          @records = populate_models(feed)
        end
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
          # Matches resource name in URL (e.g. ApplicationInformation)
          resource = '([a-zA-Z]+)'

          # Matches Base 64 encoded resource ID used by PG&E for MeterReading
          # resource identifier
          base64_id = '\w+=*'

          # Matches numeric ID with thousands separator in commas used for
          # UsageSummary IDs for PG&E endpoints but also matches traditional
          # digits without comma separator
          num_id = '(\d+,*\d*)+'

          # Matches GUID as the resource ID used mainly by PG&E for
          # ApplicationInformation resource identifier
          guid = '[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}' +
                 '-[0-9A-Fa-f]{12}'

          # Identifier can be any of the above patterns
          identifier = "(#{base64_id}|#{num_id}|#{guid})"

          match_data = /\/(#{resource}|#{resource}\/#{identifier})\/*\z/.
                       match(entry.self)

          unless match_data.nil?
            id = match_data[4] || entry.id
            type = match_data[2] || match_data[3]

            entry_content = case type.downcase

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

      def build_query_params(options)
        params = {}

        options.each do |key, value|
          if key == :published_min || key == :published_max
            if value.respond_to? :to_time
              value = value.to_time.to_i
            end
          end

          unless key == :ssl || key == :token || key == :subscription_id
            params[key.to_s.dasherize] = value
          end
        end

        return params
      end

      def url_options(options)
        url_options = {}

        options.each do |key, value|
          if /_id$/ =~ key
            url_options[key] = value
          end
        end

        return url_options
      end
    end # ClassMethods
  end # Fetchable
end # GreenButtonData
