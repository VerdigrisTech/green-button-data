module GreenButtonData
  class Model
    def self.all(url = nil, options = nil)
      feed = fetch url, options

      models = ModelCollection.new

      each_entry_content(feed) do |content|
        models << self.new content
      end

      return models
    end

    def self.get(url = nil, options = nil)
      # url or raise ArgumentError "url is required to fetch data"
      #
      # connection_options = {}
      # connection_options.ssl = options[:client_ssl] if options[:client_ssl]
      #
      # conn = Faraday.new connection_options
      # conn.token_auth(options[:token]) if options[:token]
      #
      # response = conn.get url
      #
      # if response.status == 200
      #   feed = GreenButtonData::Parser::Feed.parse response.body
      # end
    end

    def self.each_entry_content(feed)
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

    def self.fetch(url = nil, options = nil)
      url or raise ArgumentError "url is required to fetch data"

      connection_options = {}
      connection_options[:ssl] = options[:client_ssl] if options[:client_ssl]

      conn = Faraday.new connection_options
      conn.token_auth(options[:token]) if options[:token]

      response = conn.get url
      response.status == 200 and GreenButtonData::Feed.parse response.body
    end
  end
end
