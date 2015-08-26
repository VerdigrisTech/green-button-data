module GreenButtonData
  class UsageSummary < Entry
    include Enumerations
    include Utilities

    attr_reader :billing_period
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
      datetime = Time.at normalize_epoch(@status_time_stamp)

      if kwargs[:local] == true
        return datetime.localtime
      else
        return datetime.utc
      end
    end
  end
end
