module GreenButtonData
  module Enumerations
    ACCUMULATION = {
       0 => :none,
       1 => :bulk_quantity,
       2 => :continuous_cumulative,
       3 => :cumulative,
       4 => :delta_data,
       6 => :indicating,
       9 => :summation,
      10 => :time_delay,
      12 => :instantaneous,
      13 => :latching_quantity,
      14 => :bounded_quantity
    }
  end
end
