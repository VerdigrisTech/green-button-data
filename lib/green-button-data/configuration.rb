require 'uri'

module GreenButtonData
  class Configuration
    attr_accessor :base_url,
                  :application_information_path,
                  :authorization_path,
                  :interval_block_path,
                  :meter_reading_path,
                  :reading_type_path,
                  :usage_point_path,
                  :usage_summary_path

    def application_information_url
      return URI.join @base_url, @application_information_path
    end

    def application_information_url=(url)
      uri = URI.parse url
      @base_url = "#{uri.scheme}://#{uri.host}"
      @application_information_path = uri.path
    end

    def authorization_url
      return URI.join @base_url, @authorization_url
    end

    def authorization_url=(url)
      uri = URI.parse url
      @base_url = "#{uri.scheme}://#{uri.host}"
      @authorization_path = uri.path
    end

    def interval_block_url
      return URI.join @base_url, @interval_block_path
    end

    def interval_block_url=(url)
      uri = URI.parse url
      @base_url = "#{uri.scheme}://#{uri.host}"
      @interval_block_path = uri.path
    end

    def meter_reading_url
      return URI.join @base_url, @meter_reading_path
    end

    def meter_reading_url=(url)
      uri = URI.parse url
      @base_url = "#{uri.scheme}://#{uri.host}"
      @meter_reading_path = uri.path
    end

    def reading_type_url
      return URI.join @base_url, @reading_type_path
    end

    def reading_type_url=(url)
      uri = URI.parse url
      @base_url = "#{uri.scheme}://#{uri.host}"
      @reading_type_path = uri.path
    end

    def usage_point_url
      return URI.join @base_url, @usage_point_path
    end

    def usage_point_url=(url)
      uri = URI.parse url
      @base_url = "#{uri.scheme}://#{uri.host}"
      @usage_point_path = uri.path
    end

    def usage_summary_url
      return URI.join @base_url, @usage_summary_path
    end

    def usage_summary_url=(url)
      uri = URI.parse url
      @base_url = "#{uri.scheme}://#{uri.host}"
      @usage_summary_path = uri.path
    end
  end
end
