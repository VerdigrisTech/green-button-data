module GreenButtonData
  class UsagePoint
    include Fetchable

    attr_accessor :id,
                  :meter_reading_url,
                  :usage_summary_url,
                  :service_category

    def initialize(attributes)
      @id = attributes[:id]
      @meter_reading_url = attributes[:meter_reading_url]
      @usage_summary_url = attributes[:usage_summary_url]
      @service_category = attributes[:service_category]
      @meter_readings = attributes[:meter_readings]
      @usage_summary = attributes[:usage_summary]
    end

    def meter_readings
      @meter_readings ||= MeterReadings.all @meter_reading_url
    end

    def usage_summary
      # @usage_summary ||= UsageSummary.all
    end
  end
end
