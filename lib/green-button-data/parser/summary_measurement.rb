module GreenButtonData
  module Parser
    class SummaryMeasurement
      include SAXMachine
      include Enumerations

      element :powerOfTenMultiplier, class: Integer,
              as: :power_of_ten_multiplier
      element :timeStamp, as: :time_stamp
      element :uom, class: Integer
      element :value, class: Integer
      element :readingTypeRef, as: :reading_type_ref

      def power_of_ten_multiplier
        UNIT_MULTIPLIER[@power_of_ten_multiplier]
      end

      def uom
        UNIT_SYMBOL[@uom]
      end

      # ESPI Namespacing
      element :'espi:powerOfTenMultiplier', class: Integer,
              as: :power_of_ten_multiplier
      element :'espi:timeStamp', as: :time_stamp
      element :'espi:uom', class: Integer, as: :uom
      element :'espi:value', class: Integer, as: :value
      element :'espi:readingTypeRef', as: :reading_type_ref
    end
  end
end
