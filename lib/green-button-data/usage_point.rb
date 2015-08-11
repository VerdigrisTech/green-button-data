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
      else
        @meter_readings and @meter_readings.find_by_id(id) or MeterReading.find "#{@meter_reading_url}/#{id}"
      end
    end

    def usage_summary
      # @usage_summary ||= UsageSummary.all
    end
  end
end
