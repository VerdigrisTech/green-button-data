module GreenButtonData
  module Parser
    class LocalTimeParameters
      include SAXMachine
      include Dst
      include Utilities

      element :dstStartRule, as: :dst_start_rule do |string|
        string.to_i 16
      end

      element :dstEndRule, as: :dst_end_rule do |string|
        string.to_i 16
      end

      def dst_starts_at(year = Time.now.year)
        byte_to_dst_datetime @dst_start_rule, year
      end

      def dst_ends_at(year = Time.now.year)
        byte_to_dst_datetime @dst_end_rule, year
      end

      element :dstOffset, class: Integer, as: :dst_offset
      element :tzOffset, class: Integer, as: :tz_offset

      def total_offset
        @dst_offset + @tz_offset
      end

      def total_offset_hours
        total_offset / 3600
      end

      # ESPI Namespacing
      element :'espi:dstStartRule', as: :dst_start_rule
      element :'espi:dstEndRule', as: :dst_end_rule
      element :'espi:dstOffset', class: Integer, as: :dst_offset
      element :'espi:tzOffset', class: Integer, as: :tz_offset

      # Special case for PG&E which uses generic namespacing
      element :'ns0:dstStartRule', as: :dst_start_rule
      element :'ns0:dstEndRule', as: :dst_end_rule
      element :'ns0:dstOffset', class: Integer, as: :dst_offset
      element :'ns0:tzOffset', class: Integer, as: :tz_offset
    end
  end
end
