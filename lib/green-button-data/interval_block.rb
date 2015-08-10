module GreenButtonData
  class IntervalBlock
    include Fetchable

    attr_reader :id

    def initialize(attributes)
      @id = attributes[:id]
    end

    def interval_readings
      
    end
  end
end
