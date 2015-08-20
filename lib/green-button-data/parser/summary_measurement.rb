module GreenButtonData
  module Parser
    class SummaryMeasurement
      include SAXMachine

      element :powerOfTenMultiplier, as: :power_of_ten_multiplier
      element :timeStamp, as: :time_stamp
      element :uom
      element :value, class: Integer
      element :readingTypeRef, as: :reading_type_ref

      def power_of_ten_multiplier
        UNIT_MULTIPLIER[@power_of_ten_multiplier] if @power_of_ten_multiplier
      end

      def uom
        UNIT_SYMBOL[@uom] if @uom
      end
    end
  end
end
