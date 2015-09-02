module GreenButtonData
  module Dst
    # From ESPI XML schema:
    # [extension] Bit map encoded rule from which is calculated the start or
    # end time, within the current year, to which daylight savings time offset
    # must be applied.
    #
    # The rule encoding:
    # Bits  0 - 11: seconds 0 - 3599
    # Bits 12 - 16: hours 0 - 23
    # Bits 17 - 19: day of the week 0 = not applicable, 1 - 7 (Monday = 1)
    # Bits:20 - 24: day of the month 0 = not applicable, 1 - 31
    # Bits: 25 - 27: operator  (detailed below)
    # Bits: 28 - 31: month 1 - 12
    #
    # Rule value of 0xFFFFFFFF means rule processing/DST correction is disabled.
    #
    # The operators:
    #
    # 0: DST starts/ends on the Day of the Month
    # 1: DST starts/ends on the Day of the Week that is on or after the Day of the Month
    # 2: DST starts/ends on the first occurrence of the Day of the Week in a month
    # 3: DST starts/ends on the second occurrence of the Day of the Week in a month
    # 4: DST starts/ends on the third occurrence of the Day of the Week in a month
    # 5: DST starts/ends on the forth occurrence of the Day of the Week in a month
    # 6: DST starts/ends on the fifth occurrence of the Day of the Week in a month
    # 7: DST starts/ends on the last occurrence of the Day of the Week in a month
    #
    # An example: DST starts on third Friday in March at 1:45 AM.  The rule...
    # Seconds: 2700
    # Hours: 1
    # Day of Week: 5
    # Day of Month: 0
    # Operator: 4
    # Month: 3
    BITMASK_SECOND = 0x00000fff
    BITMASK_HOUR = 0x0001f000
    BITMASK_DAY_OF_WEEK = 0x000e0000
    BITMASK_DAY_OF_MONTH = 0x01f00000
    BITMASK_DST_RULE = 0x0e000000
    BITMASK_MONTH = 0xf0000000

    BITSHIFT_HOUR = 12
    BITSHIFT_DAY_OF_WEEK = 17
    BITSHIFT_DAY_OF_MONTH = 20
    BITSHIFT_DST_RULE = 25
    BITSHIFT_MONTH = 28

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
      seconds.between?(0, 3599) and hour.between?(0, 23) and
      weekday.between?(1, 7) and day.between?(0, 31) and
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
