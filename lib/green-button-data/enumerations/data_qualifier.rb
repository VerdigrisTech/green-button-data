module GreenButtonData
  module Enumerations
    DATA_QUALIFIER = {
       0 => :none,
       2 => :average,
       4 => :excess,
       5 => :high_threshold,
       7 => :low_threshold,
       8 => :maximum,
       9 => :minimum,
      11 => :nominal,
      12 => :normal,
      16 => :second_maximum,
      17 => :second_minimum,
      23 => :third_maximum,
      24 => :fourth_maximum,
      25 => :fifth_maximum,
      26 => :sum
    }
  end
end
