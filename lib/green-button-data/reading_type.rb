module GreenButtonData
  class ReadingType < Entry
    include Enumerations

    attr_reader :consumption_tier, :cpp, :tou

    def accumulation_behaviour
      get_enum_symbol ACCUMULATION, @accumulation_behaviour
    end

    def commodity
      get_enum_symbol COMMODITY, @commodity
    end

    def currency
      get_enum_symbol CURRENCY, @currency
    end

    def data_qualifier
      get_enum_symbol DATA_QUALIFIER, @data_qualifier
    end

    def default_quality
      get_enum_symbol QUALITY_OF_READING, @default_quality
    end

    def flow_direction
      get_enum_symbol FLOW_DIRECTION, @flow_direction
    end

    def kind
      get_enum_symbol MEASUREMENT, @kind
    end

    def measuring_period
      get_enum_symbol TIME_ATTRIBUTE, @measuring_period
    end

    def phase
      get_enum_symbol PHASE_CODE, @phase
    end

    def scale_factor
      10.0 ** @power_of_ten_multiplier
    end

    def time_attribute
      get_enum_symbol TIME_PERIOD_OF_INTEREST, @time_attribute
    end

    def unit_of_measurement
      get_enum_symbol UNIT_SYMBOL, @uom
    end

    alias_method :unit, :unit_of_measurement
    alias_method :uom, :unit_of_measurement

    def to_h
      {
        accumulation_behaviour: accumulation_behaviour,
        commodity: commodity,
        consumption_tier: consumption_tier,
        cpp: cpp,
        currency: currency,
        data_qualifier: data_qualifier,
        default_quality: default_quality,
        flow_direction: flow_direction,
        kind: kind,
        measuring_period: measuring_period,
        phase: phase,
        scale_factor: scale_factor,
        time_attribute: time_attribute,
        tou: tou,
        unit_of_measurement: unit_of_measurement
      }
    end
  end
end
