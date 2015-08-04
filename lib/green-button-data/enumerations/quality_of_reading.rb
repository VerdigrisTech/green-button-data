module GreenButtonData
  module Enumerations
    QUALITY_OF_READING = {
       0 => :valid,
       7 => :manually_edited,
       8 => :estimated_using_reference_day,
       9 => :estimated_using_linear_interpolation,
      10 => :questionable,
      11 => :derived,
      12 => :projected_forecast,
      13 => :mixed,
      14 => :raw,
      15 => :normalized_for_weather,
      16 => :other,
      17 => :validated,
      18 => :verified,
      19 => :revenue_quality
    }
  end
end
