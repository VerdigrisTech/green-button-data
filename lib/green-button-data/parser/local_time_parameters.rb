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
      element :'espi:dstOffset', as: :dst_offset
      element :'espi:tzOffset', as: :tz_offset

      # Special case for PG&E which uses generic namespacing
      element :'ns0:dstStartRule', as: :dst_start_rule
      element :'ns0:dstEndRule', as: :dst_end_rule
      element :'ns0:dstOffset', as: :dst_offset
      element :'ns0:tzOffset', as: :tz_offset
      element :'ns1:dstStartRule', as: :dst_start_rule
      element :'ns1:dstEndRule', as: :dst_end_rule
      element :'ns1:dstOffset', as: :dst_offset
      element :'ns1:tzOffset', as: :tz_offset

      private

      def byte_to_dst_datetime(byte, year = Time.now.year)
        # Bits 0 - 11: seconds 0 - 3599
        seconds = byte & BITMASK_SECOND

        # Bits 12 - 16: hours 0 - 23
        hour = (byte & BITMASK_HOUR) >> BITSHIFT_HOUR

        # Bits 17 - 19: day of the week; 0 = NA, 1 - 7 (Monday = 1)
        weekday = (byte & BITMASK_DAY_OF_WEEK) >> BITSHIFT_DAY_OF_WEEK

        # Bits 20 - 24: day of the month; 0 = NA, 1 - 31
        day = (byte & BITMASK_DAY_OF_MONTH) >> BITSHIFT_DAY_OF_MONTH

        # Bits 25 - 27: DST rule 0 - 7
        dst_rule = (byte & BITMASK_DST_RULE) >> BITSHIFT_DST_RULE

        # Bits 28 - 31: month 1 - 12
        month = (byte & BITMASK_MONTH) >> BITSHIFT_MONTH

        # Raise an error unless all the values are in valid range
        second.between?(0, 3599) and hour.between?(0, 23) and
        weekday.between?(1, 7) and day.between?(1, 31) and
        dst_rule.between?(0, 7) and month.between?(1, 12) or
        raise RangeError, 'Invalid value range'

        # In Ruby, Sunday = 0 not 7
        weekday = weekday == 7 ? 0 : weekday

        # Check the DST rule
        dst_day = if dst_rule == 1
          # Rule 1: DST starts/ends on Day of Week on or after the Day of Month
          day_of_month = DateTime.new year, month, day
          day_offset = if weekday >= day_of_month.wday
            weekday - day_of_month.wday
          else
            7 + weekday - day_of_month.wday
          end

          day_of_month + day_offset
        elsif dst_rule.between?(2, 6)
          # Rule 2 - 6: DST starts/ends on Nth Day of Week in given month
          # Nth Day of Week (e.g. third Friday of July)
          nth_weekday_of year, month, weekday, dst_rule - 1
        elsif dst_rule == 7
          # Rule 7: DST starts/ends on last Day of Week in given month
          last_weekday_of year, month, weekday
        else
          # Rule 0: DST starts/ends on the Day of Month
          DateTime.new year, month, day
        end

        # Add the hour and seconds component to the day
        dst_day + Rational(hour * 3600 + seconds, 86400)
      end
    end
  end
end
