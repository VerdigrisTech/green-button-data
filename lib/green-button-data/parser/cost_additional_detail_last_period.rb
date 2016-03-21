module GreenButtonData
  module Parser
    class CostAdditionalDetailLastPeriod
      include SAXMachine

      element :powerOfTenMultiplier, class: Integer,
              as: :power_of_ten_multiplier
      element :uom, class: Integer
      element :value, class: Integer
      element :note
      element :itemKind, class: Integer, as: :item_kind

      def value
        @value
      end

      def note
        @note
      end

      # ESPI Namespacing
      element :'espi:powerOfTenMultiplier', class: Integer,
              as: :power_of_ten_multiplier
      element :'espi:uom', class: Integer, as: :uom
      element :'espi:value', class: Integer, as: :value
      element :'espi:note', as: :note
      element :'espi:itemKind', class: Integer, as: :item_kind

      # Special case for PG&E generic namespacing
      element :'ns0:powerOfTenMultiplier', class: Integer,
              as: :power_of_ten_multiplier
      element :'ns0:uom', class: Integer, as: :uom
      element :'ns0:value', class: Integer, as: :value
      element :'ns0:note', as: :note
      element :'ns0:itemKind', class: Integer, as: :item_kind
    end
  end
end