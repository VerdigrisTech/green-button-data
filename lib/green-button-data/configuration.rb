require 'uri'

module GreenButtonData
  class Configuration
    attr_accessor :base_url,
                  :application_information_path,
                  :authorization_path,
                  :interval_block_path,
                  :local_time_parameters_path,
                  :meter_reading_path,
                  :reading_type_path,
                  :subscription_path,
                  :usage_point_path,
                  :usage_summary_path

    def application_information_url(id = nil)
      uri = URI.join @base_url, @application_information_path
      uri = URI.join uri, "#{id}/" if id
      return uri.to_s
    end

    def application_information_url=(url)
      uri = URI.parse url
      @base_url = "#{uri.scheme}://#{uri.host}"
      @application_information_path = uri.path
    end

    def authorization_url(id = nil)
      uri = URI.join @base_url, @authorization_path
      uri = URI.join uri, "#{id}/" if id
      return uri.to_s
    end

    def authorization_url=(url)
      uri = URI.parse url
      @base_url = "#{uri.scheme}://#{uri.host}"
      @authorization_path = uri.path
    end

    def interval_block_url(kwargs = {})
      subscription_id = kwargs[:subscription_id]
      usage_point_id = kwargs[:usage_point_id]
      meter_reading_id = kwargs[:meter_reading_id]
      interval_block_id = kwargs[:interval_block_id]

      uri = if subscription_id && usage_point_id && meter_reading_id
        meter_reading_uri = meter_reading_url(
          subscription_id: subscription_id,
          usage_point_id: usage_point_id,
          meter_reading_id: meter_reading_id
        )

        URI.join meter_reading_uri, @interval_block_path
      else
        URI.join @base_url, @interval_block_path
      end

      uri = URI.join uri, "#{interval_block_id}/" if interval_block_id

      return uri.to_s
    end

    def local_time_parameters_url(id = nil)
      uri = URI.join @base_url, @local_time_parameters_path
      uri = URI.join uri, "#{id}/" if id
      return uri.to_s
    end

    def meter_reading_url(kwargs = {})
      subscription_id = kwargs[:subscription_id]
      usage_point_id = kwargs[:usage_point_id]
      meter_reading_id = kwargs[:meter_reading_id]

      uri = if subscription_id && usage_point_id
        usage_point_uri = usage_point_url(
          subscription_id: subscription_id,
          usage_point_id: usage_point_id
        )

        URI.join usage_point_uri, @meter_reading_path
      else
        URI.join @base_url, @meter_reading_path
      end

      uri = URI.join uri, "#{meter_reading_id}/" if meter_reading_id

      return uri.to_s
    end

    def reading_type_url(id = nil)
      uri = URI.join @base_url, @reading_type_path
      uri = URI.join uri, "#{id}/" if id

      return uri.to_s
    end

    def subscription_url(id)
      uri = URI.join @base_url, @subscription_path
      uri = URI.join uri, "#{id}/" if id
      return uri.to_s
    end

    def usage_point_url(kwargs = {})
      subscription_id = kwargs[:subscription_id]
      usage_point_id = kwargs[:usage_point_id]

      uri = if subscription_id
        subscription_uri = subscription_url subscription_id

        URI.join subscription_uri, @usage_point_path
      else
        URI.join @base_url, @usage_point_path
      end

      uri = URI.join uri, "#{usage_point_id}/" if usage_point_id

      return uri.to_s
    end

    def usage_summary_url(kwargs = {})
      subscription_id = kwargs[:subscription_id]
      usage_point_id = kwargs[:usage_point_id]

      if subscription_id && usage_point_id
        usage_point_uri = usage_point_url subscription_id: subscription_id,
                                          usage_point_id: usage_point_id

        return URI.join(usage_point_uri, @usage_summary_path).to_s
      elsif subscription_id
        raise ArgumentError.new "Missing required argument: usage_point_id"
      elsif usage_point_id
        raise ArgumentError.new "Missing required argument: subscription_id"
      else
        raise ArgumentError.new "Missing required arguments: subscription_id," +
                                " usage_point_id"
      end
    end
  end
end
