module GreenButtonData
  module Parser
    class IntervalReading
      include SAXMachine

      element :cost, class: Integer
      element :timePeriod, class: Interval, as: :time_period
      element :value, class: Integer

      # Standard ESPI namespacing
      element :'espi:cost', class: Integer, as: :cost
      element :'espi:timePeriod', class: Interval, as: :time_period
      element :'espi:value', class: Integer, as: :value

      # Special case for PG&E which uses generic namespacing
      element :'ns0:cost', class: Integer, as: :cost
      element :'ns0:timePeriod', class: Interval, as: :time_period
      element :'ns0:value', class: Integer, as: :value
      element :'ns1:cost', class: Integer, as: :cost
      element :'ns1:timePeriod', class: Interval, as: :time_period
      element :'ns1:value', class: Integer, as: :value
    end
  end
end
