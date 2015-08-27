module GreenButtonData
  class IntervalBlock < Entry
    attr_accessor :length, :starts_at, :ends_at, :duration

    def initialize(attributes)
      super

      @starts_at = @interval.starts_at local: true
      @ends_at = @interval.ends_at local: true
      @duration = @interval.duration
      @length = @interval_readings.size
    end
  end
end
