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

      def starts_at(kwargs = {})
        epoch_to_time @start, kwargs
      end

      def ends_at(kwargs = {})
        epoch_to_time @start + @duration, kwargs
      end

      def to_s
        "#{starts_at} - #{ends_at}"
      end

      # Standard ESPI namespacing
      element :'espi:duration', class: Integer, as: :duration
      element :'espi:start', class: Integer, as: :start

      # Special case for PG&E which uses generic namespacing
      element :'ns0:duration', class: Integer, as: :duration
      element :'ns0:start', class: Integer, as: :start
    end
  end
end
