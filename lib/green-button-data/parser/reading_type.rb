module GreenButtonData
  module Parser
    class ReadingType
      include SAXMachine
      include Enumerations

      element :accumulationBehaviour, class: Integer,
              as: :accumulation_behaviour
      element :commodity, class: Integer
      element :consumptionTier, class: Integer, as: :consumption_tier
      element :currency, class: Integer
      element :dataQualifier, class: Integer, as: :data_qualifier
      element :defaultQuality, class: Integer, as: :default_quality
      element :flowDirection, class: Integer, as: :flow_direction
      element :intervalLength, class: Integer, as: :interval_length
      element :kind, class: Integer
      element :phase, class: Integer
      element :powerOfTenMultiplier, class: Integer,
              as: :power_of_ten_multiplier
      element :timeAttribute, class: Integer, as: :time_attribute
      element :tou, class: Integer
      element :uom, class: Integer
      element :cpp, class: Integer
      element :interharmonic, class: RationalNumber
      element :measuringPeriod, class: Integer, as: :measuring_period
      element :argument, class: RationalNumber

      def accumulation_behaviour
        ACCUMULATION[@accumulation_behaviour]
      end

      def argument
        unless @argument.denominator == 0
          @argument.numerator / @argument.denominator
        end
      end

      def commodity
        COMMODITY[@commodity]
      end

      def currency
        CURRENCY[@currency]
      end

      def data_qualifier
        DATA_QUALIFIER[@data_qualifier]
      end

      def default_quality
        QUALITY_OF_READING[@default_quality]
      end

      def flow_direction
        FLOW_DIRECTION[@flow_direction]
      end

      def interharmonic
        # Prevent blackholes from forming
        unless @interharmonic.denominator == 0
          @interharmonic.numerator / @interharmonic.denominator
        end
      end

      def kind
        MEASUREMENT[@kind]
      end

      def measuring_period
        TIME_ATTRIBUTE[@measuring_period]
      end

      def phase
        PHASE_CODE[@phase]
      end

      def power_of_ten_multiplier
        10.0 ** @power_of_ten_multiplier
      end

      def time_attribute
        TIME_PERIOD_OF_INTEREST[@time_attribute]
      end

      def uom
        UNIT_SYMBOL[@uom]
      end

      # ESPI Namespacing
      element :'espi:accumulationBehaviour', class: Integer,
              as: :accumulation_behaviour
      element :'espi:commodity', class: Integer, as: :commodity
      element :'espi:consumptionTier', class: Integer, as: :consumption_tier
      element :'espi:currency', class: Integer, as: :currency
      element :'espi:dataQualifier', class: Integer, as: :data_qualifier
      element :'espi:defaultQuality', class: Integer, as: :default_quality
      element :'espi:flowDirection', class: Integer, as: :flow_direction
      element :'espi:intervalLength', class: Integer, as: :interval_length
      element :'espi:kind', class: Integer, as: :kind
      element :'espi:phase', class: Integer, as: :phase
      element :'espi:powerOfTenMultiplier', class: Integer,
              as: :power_of_ten_multiplier
      element :'espi:timeAttribute', class: Integer, as: :time_attribute
      element :'espi:tou', class: Integer, as: :tou
      element :'espi:uom', class: Integer, as: :uom
      element :'espi:cpp', class: Integer, as: :cpp
      element :'espi:interharmonic', class: RationalNumber, as: :interharmonic
      element :'espi:measuringPeriod', class: Integer, as: :measuring_period
      element :'espi:argument', class: RationalNumber, as: :argument

      # Special case for PG&E which uses generic namespacing
      element :'ns0:accumulationBehaviour', class: Integer,
              as: :accumulation_behaviour
      element :'ns0:commodity', class: Integer, as: :commodity
      element :'ns0:consumptionTier', class: Integer, as: :consumption_tier
      element :'ns0:currency', class: Integer, as: :currency
      element :'ns0:dataQualifier', class: Integer, as: :data_qualifier
      element :'ns0:defaultQuality', class: Integer, as: :default_quality
      element :'ns0:flowDirection', class: Integer, as: :flow_direction
      element :'ns0:intervalLength', class: Integer, as: :interval_length
      element :'ns0:kind', class: Integer, as: :kind
      element :'ns0:phase', class: Integer, as: :phase
      element :'ns0:powerOfTenMultiplier', class: Integer,
              as: :power_of_ten_multiplier
      element :'ns0:timeAttribute', class: Integer, as: :time_attribute
      element :'ns0:tou', class: Integer, as: :tou
      element :'ns0:uom', class: Integer, as: :uom
      element :'ns0:cpp', class: Integer, as: :cpp
      element :'ns0:interharmonic', class: RationalNumber, as: :interharmonic
      element :'ns0:measuringPeriod', class: Integer, as: :measuring_period
      element :'ns0:argument', class: RationalNumber, as: :argument
      element :'ns1:accumulationBehaviour', class: Integer,
              as: :accumulation_behaviour
      element :'ns1:commodity', class: Integer, as: :commodity
      element :'ns1:consumptionTier', class: Integer, as: :consumption_tier
      element :'ns1:currency', class: Integer, as: :currency
      element :'ns1:dataQualifier', class: Integer, as: :data_qualifier
      element :'ns1:defaultQuality', class: Integer, as: :default_quality
      element :'ns1:flowDirection', class: Integer, as: :flow_direction
      element :'ns1:intervalLength', class: Integer, as: :interval_length
      element :'ns1:kind', class: Integer, as: :kind
      element :'ns1:phase', class: Integer, as: :phase
      element :'ns1:powerOfTenMultiplier', class: Integer,
              as: :power_of_ten_multiplier
      element :'ns1:timeAttribute', class: Integer, as: :time_attribute
      element :'ns1:tou', class: Integer, as: :tou
      element :'ns1:uom', class: Integer, as: :uom
      element :'ns1:cpp', class: Integer, as: :cpp
      element :'ns1:interharmonic', class: RationalNumber, as: :interharmonic
      element :'ns1:measuringPeriod', class: Integer, as: :measuring_period
      element :'ns1:argument', class: RationalNumber, as: :argument
    end
  end
end
