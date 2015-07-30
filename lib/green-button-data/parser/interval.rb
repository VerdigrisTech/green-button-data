module GreenButtonData
  module Parser
    class Interval
      include SAXMachine
      include Utilities

      element :duration, class: Integer do |t|
        normalize_epoch t
      end

      element :start, class: Integer do |t|
        normalize_epoch t
      end

      def start_at
        Time.at(normalize_epoch(@start)).utc.to_datetime
      end

      def end_at
        Time.at(normalize_epoch(@start + @duration)).utc.to_datetime
      end

      # Standard ESPI namespacing
      element :'espi:duration', class: Integer, as: :duration
      element :'espi:start', class: Integer, as: :start

      # Special case for PG&E which uses generic namespacing
      element :'ns0:duration', class: Integer, as: :duration
      element :'ns0:start', class: Integer, as: :start
      element :'ns1:duration', class: Integer, as: :duration
      element :'ns1:start', class: Integer, as: :start
    end
  end
end
