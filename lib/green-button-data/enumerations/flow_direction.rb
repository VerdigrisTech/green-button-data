module GreenButtonData
  module Enumerations
    FLOW_DIRECTION = {
       0 => :none,
       1 => :forward,
       2 => :lagging,
       3 => :leading,
       4 => :net,
       5 => :q1plus_q2,
       7 => :q1plus_q3,
       8 => :q1plus_q4,
       9 => :q1minus_q4,
      10 => :q2plus_q3,
      11 => :q2plus_q4,
      12 => :q2minus_q3,
      13 => :q3plus_q4,
      14 => :q3minus_q2,
      15 => :quadrant1,
      16 => :quadrant2,
      17 => :quadrant3,
      18 => :quadrant4,
      19 => :reverse,
      20 => :total,
      21 => :total_by_phase
    }
  end
end
