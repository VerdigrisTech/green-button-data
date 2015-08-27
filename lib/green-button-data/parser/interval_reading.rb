module GreenButtonData
  module Parser
    class IntervalReading
      include SAXMachine
      include Enumerations

      element :cost, class: Integer
      element :quality, class: Integer
      element :timePeriod, class: Interval, as: :time_period
      element :value, class: Integer
      element :consumptionTier, class: Integer, as: :consumption_tier
      element :tou, class: Integer
      element :cpp, class: Integer

      def quality
        if @quality.is_a? Numeric
          QUALITY_OF_READING[@quality]
        else
          @quality
        end
      end

      # Standard ESPI namespacing
      element :'espi:cost', class: Integer, as: :cost
      element :'espi:quality', class: Integer, as: :quality
      element :'espi:timePeriod', class: Interval, as: :time_period
      element :'espi:value', class: Integer, as: :value
      element :'espi:consumptionTier', class: Integer, as: :consumption_tier
      element :'espi:tou', class: Integer, as: :tou
      element :'espi:cpp', class: Integer, as: :cpp

      # Special case for PG&E which uses generic namespacing
      element :'ns0:cost', class: Integer, as: :cost
      element :'ns0:quality', class: Integer, as: :quality
      element :'ns0:timePeriod', class: Interval, as: :time_period
      element :'ns0:value', class: Integer, as: :value
      element :'ns0:consumptionTier', class: Integer, as: :consumption_tier
      element :'ns0:tou', class: Integer, as: :tou
      element :'ns0:cpp', class: Integer, as: :cpp
    end
  end
end
