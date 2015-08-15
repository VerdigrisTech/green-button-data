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

    def usage_summary
      # @usage_summary ||= UsageSummary.all
    end
  end
end
