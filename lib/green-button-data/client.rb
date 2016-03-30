module GreenButtonData
  class Client
    attr_accessor :configuration,
                  :ssl,
                  :token

    def initialize(config)
      @configuration = GreenButtonData::Configuration.new

      config.each do |key, value|
        if @configuration.respond_to? "#{key}="
          @configuration.send "#{key}=", value
        end
      end
    end

    def application_information(id = nil, options = {})
      if id.is_a? Hash
        options = id
        id = nil
      end

      get_resource(
        @configuration.application_information_url(id),
        id,
        ApplicationInformation,
        options
      )
    end

    def authorization(id = nil, options = {})
      if id.is_a? Hash
        options = id
        id = nil
      end

      get_resource(
        @configuration.authorization_url(id),
        id,
        Authorization,
        sanitize_options(options)
      )
    end

    def interval_block(id = nil, options = {})
      if id.is_a? Hash
        options = id
        id = nil
      end

      id ||= options[:interval_block_id]
      meter_reading_id = options[:meter_reading_id]
      usage_point_id = options[:usage_point_id]
      subscription_id = options[:subscription_id]

      get_resource(
        @configuration.interval_block_url(
          interval_block_id: id,
          meter_reading_id: meter_reading_id,
          usage_point_id: usage_point_id,
          subscription_id: subscription_id
        ),
        id,
        IntervalBlock,
        sanitize_options(options)
      )
    end

    def local_time_parameters(id = nil, options = {})
      if id.is_a? Hash
        options = id
        id = nil
      end

      get_resource(
        @configuration.local_time_parameters_url(id),
        id,
        LocalTimeParameters,
        sanitize_options(options)
      )
    end

    def meter_reading(id = nil, options = {})
      if id.is_a? Hash
        options = id
        id = nil
      end

      id ||= options[:meter_reading_id]
      usage_point_id = options[:usage_point_id]
      subscription_id = options[:subscription_id]

      get_resource(
        @configuration.meter_reading_url(
          meter_reading_id: id,
          usage_point_id: usage_point_id,
          subscription_id: subscription_id
        ),
        id,
        MeterReading,
        sanitize_options(options)
      )
    end

    def reading_type(id = nil, options = {})
      if id.is_a? Hash
        options = id
        id = nil
      end

      get_resource(
        @configuration.reading_type_url(id),
        id,
        ReadingType,
        sanitize_options(options)
      )
    end

    def ssl=(ssl)
      ssl == nil || ssl.is_a?(Hash) or raise ArgumentError.new(
        "SSL options attribute must be a Hash"
      )

      @ssl = ssl
    end

    def token=(token)
      token == nil || token.is_a?(String) or raise ArgumentError.new(
        "Request token must be a string"
      )

      @token = token
    end

    def usage_point(id = nil, options = {})
      if id.is_a? Hash
        options = id
        id = nil
      end

      id ||= options[:usage_point_id]
      subscription_id = options[:subscription_id]

      get_resource(
        @configuration.usage_point_url(
          usage_point_id: id,
          subscription_id: subscription_id
        ),
        id,
        UsagePoint,
        sanitize_options(options)
      )
    end

    def usage_summary(id = nil, options = {})
      if id.is_a? Hash
        options = id
        id = nil
      end

      id ||= options[:usage_summary_id]
      usage_point_id = options[:usage_point_id]
      subscription_id = options[:subscription_id]

      get_resource(
        @configuration.usage_summary_url(
          usage_summary_id: id,
          usage_point_id: usage_point_id,
          subscription_id: subscription_id
        ),
        id,
        UsageSummary,
        sanitize_options(options)
      )
    end

    def retail_customer(id = nil, options = {})
      if id.is_a? Hash
        options = id
        id = nil
      end

      retail_customer_id = options[:subscription_id]

      get_resource(
        @configuration.retail_customer_url(
          subscription_id: retail_customer_id
        ),
        id,
        RetailCustomer,
        sanitize_options(options)
      )
    end

    private

    def get_resource(url, id = nil, klazz = nil, options = {})
      klazz ||= Entry.class_from_name Entry.class_name_from_url url

      # Merge request options
      options[:token] ||= token if token
      options[:ssl] ||= ssl if ssl

      if id
        klazz.find url, options
      else
        klazz.all url, options
      end
    end

    def sanitize_options(options)
      options.delete(:interval_block_id) if options.has_key? :interval_block_id
      options.delete(:meter_reading_id) if options.has_key? :meter_reading_id
      options.delete(:subscription_id) if options.has_key? :subscription_id
      options.delete(:usage_point_id) if options.has_key? :usage_point_id
      options.delete(:usage_summary_id) if options.has_key? :usage_summary_id
      options
    end
  end
end
