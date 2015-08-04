module GreenButtonData
  module Enumerations
    TIME_PERIOD_OF_INTEREST = {
       0 => :none,
       8 => :billing_period,
      11 => :daily,
      13 => :monthly,
      22 => :seasonal,
      24 => :weekly,
      32 => :specified_period
    }
  end
end
