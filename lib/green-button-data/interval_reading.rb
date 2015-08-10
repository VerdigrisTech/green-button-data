module GreenButtonData
  class IntervalReading
    include Interval

    def initialize(attributes)
      @cost = attributes[:cost]
      @value = attributes[:value]
      @reading_quality = attributes[:reading_quality]
      @tou = attributes[:tou]
      @cpp = attributes[:cpp]
    end
  end
end
