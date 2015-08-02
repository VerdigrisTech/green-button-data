module GreenButtonData
  module Parser
    class IntervalBlock
      include SAXMachine

      element :interval, class: Interval
      elements :IntervalReading, class: IntervalReading, as: :interval_readings

      def duration
        @interval.duration
      end

      def starts_at
        @interval.starts_at
      end

      def ends_at
        @interval.ends_at
      end

      # Standard ESPI namespacing
      element :'espi:interval', class: Interval, as: :interval
      element :'espi:IntervalReading', class: IntervalReading,
              as: :interval_readings

      # Special case for PG&E which uses generic namespacing
      element :'ns0:interval', class: Interval, as: :interval
      element :'ns0:IntervalReading', class: IntervalReading,
              as: :interval_readings
    end
  end
end
