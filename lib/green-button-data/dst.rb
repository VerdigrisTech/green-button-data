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
  end
end
