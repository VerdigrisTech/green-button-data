module GreenButtonData
  module Parser
    class CostAdditionalDetailLastPeriod < SummaryMeasurement
      element :note
      element :itemKind, class: Integer, as: :item_kind

      # ESPI Namespacing
      element :'espi:note', as: :note
      element :'espi:itemKind', class: Integer, as: :item_kind

      # Special case for PG&E generic namespacing
      element :'ns0:note', as: :note
      element :'ns0:itemKind', class: Integer, as: :item_kind
    end
  end
end
