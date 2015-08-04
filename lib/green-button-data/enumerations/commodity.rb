module GreenButtonData
  module Enumerations
    COMMODITY = {
       0 => :none,                          # NA
       1 => :electricity_secondary_metered, # Secondary electricity meter
       2 => :electricity_primary_metered,   # Primary electricity meter
       3 => :communication,                 # A measurement of the communication infrastructure itself
       4 => :air,                           # Air
       5 => :insulative_gas,                # SF6 is found below (ID: 22)
       6 => :insulative_oil,                # Oil for insulation
       7 => :natural_gas,                   # Natural gas (LNG)
       8 => :propane,                       # Propane gas (LPG)
       9 => :potable_water,                 # Drinkable water (drinking fountains)
      10 => :steam,                         # Water in steam form; usually for heating
      11 => :waste_water,                   # Sewerage
      12 => :heating_fluid,                 # Fluid for heating in liquid form
      13 => :cooling_fluid,                 # Cooling fluid; returns warmer than sent
      14 => :nonpotable_water,              # Reclaimed water
      15 => :nox,                           # Nitrous Oxides
      16 => :so2,                           # Sulfur Dioxide SO₂
      17 => :ch4,                           # Methane CH₄
      18 => :co2,                           # Carbon Dioxide CO₂
      19 => :carbon,                        # Carbon
      20 => :hch,                           # Hexachlorocyclohexane HCH
      21 => :pfc,                           # Perfluorocarbons PFC
      22 => :sf6,                           # Sulfurhexafluoride SF₆
      23 => :tv_license,                    # Television
      24 => :internet,                      # Internet service
      25 => :refuse                         # Trash
    }
  end
end
