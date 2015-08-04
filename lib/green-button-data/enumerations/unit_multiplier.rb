module GreenButtonData
  module Enumerations
    UNIT_MULTIPLIER = {
      -12 => :p,      # Pico: 10^-12
       -9 => :n,      # Nano: 10^-9
       -6 => :micro,  # Micro: 10^-6
       -3 => :m,      # Milli: 10^-3
       -1 => :d,      # Deci: 10^-1
        0 => :none,   # N/A
        1 => :da,     # Deca: 10^1
        2 => :h,      # Hecto: 10^2
        3 => :k,      # Kilo: 10^3
        6 => :M,      # Mega: 10^6
        9 => :G,      # Giga: 10^9
       12 => :T,      # Tera: 10^12
    }
  end
end
