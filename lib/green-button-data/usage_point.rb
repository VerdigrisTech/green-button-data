module GreenButtonData
  class UsagePoint < Entry
    include Enumerations

    attr_accessor :id,
                  :service_category

    def initialize(attributes)
      super
      @meter_readings = attributes[:meter_readings]
      @usage_summary = attributes[:usage_summary]
    end

    def service_category
      SERVICE[@kind]
    end

    def meter_readings(id = nil)
      if id.nil?
        @meter_readings ||= MeterReading.all @meter_reading_url

        return @meter_readings
      else
        # Try returning cached results first
        @meter_readings and meter_reading = @meter_readings.find_by_id(id)
        cache_miss = meter_reading.nil?

        # Cache-miss; send API request
        meter_reading ||= MeterReading.find("#{@meter_reading_url}/#{id}")

        # Cache the result
        unless @meter_readings
          @meter_readings = ModelCollection.new
          @meter_readings << meter_reading if cache_miss
        end

        return meter_reading
      end
    end

    def usage_summary_url
      return @usage_summary_url || @electric_power_usage_summary_url
    end

    def usage_summaries(id = nil)
      if id.nil?
        @usage_summaries ||= UsageSummary.all(usage_summary_url)

        return @usage_summaries
      else
        # Try returning cached results first
        @usage_summaries and usage_summary = @usage_summaries.find_by_id(id)
        cache_miss = usage_summary.nil?

        # Cache-miss; send API request
        usage_summary ||= UsageSummary.find("#{usage_summary_url}/#{id}")

        # Cache the result
        unless @usage_summaries
          @usage_summaries = ModelCollection.new
          @usage_summaries << usage_summary if cache_miss
        end

        return usage_summary
      end
    end
  end
end
