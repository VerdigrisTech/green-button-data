module GreenButtonData
  class UsageSummary < Entry
    include Enumerations
    include Utilities

    attr_reader :billing_period,
                :overall_consumption_last_period,
                :tariff,
                :cost_additional_detail_last_periods

    attr_writer :commodity,
                :quality_of_reading

    def commodity
      if @commodity.is_a? Numeric
        COMMODITY[@commodity]
      elsif @commodity.is_a? Symbol
        @commodity
      end
    end

    def quality_of_reading
      if @quality_of_reading.is_a? Numeric
        QUALITY_OF_READING[@quality_of_reading]
      elsif @quality_of_reading.is_a? Symbol
        @quality_of_reading
      end
    end

    def status_timestamp(kwargs = {})
      epoch_to_time @status_time_stamp, kwargs
    end

    def to_s
      "#{@billing_period}: #{@overall_consumption_last_period}"
    end
  end
end
