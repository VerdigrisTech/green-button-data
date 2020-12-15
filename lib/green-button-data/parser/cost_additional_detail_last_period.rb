module GreenButtonData
  module Parser
    class CostAdditionalDetailLastPeriod < SummaryMeasurement
      element :amount, class: Integer, as: :amount
      element :itemKind, class: Integer, as: :item_kind
      element :itemPeriod, class: Interval, as: :item_period
      element :note
      element :unitCost, class: Integer, as: :unit_cost

      # ESPI Namespacing
      element :'espi:amount', class: Integer, as: :amount
      element :'espi:itemKind', class: Integer, as: :item_kind
      element :'espi:itemPeriod', class: Interval, as: :item_period
      element :'espi:note', as: :note
      element :'espi:unitCost', class: Integer, as: :unit_cost

      # Special case for PG&E generic namespacing
      element :'ns0:amount', class: Integer, as: :amount
      element :'ns0:itemKind', class: Integer, as: :item_kind
      element :'ns0:itemPeriod', class: Interval, as: :item_period
      element :'ns0:note', as: :note
      element :'ns0:unitCost', class: Integer, as: :unit_cost

      def cost
        @amount / 100_000.0 if @amount.class == Integer
      end
    end
  end
end
