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

    def meter_readings
      @meter_readings ||= MeterReadings.all @meter_reading_url
    end

    def usage_summary
      # @usage_summary ||= UsageSummary.all
    end
  end
end
