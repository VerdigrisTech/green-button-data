module GreenButtonData
  module Parser
    class ServiceCategory
      include SAXMachine

      element :kind, class: Integer do |kind|
        GreenButtonData::Enumerations::SERVICE[kind]
      end

      # ESPI Namespacing
      element :'espi:kind', class: Integer, as: :kind

      # Special case for PG&E which uses generic namespacing
      element :'ns0:kind', class: Integer, as: :kind
    end
  end
end
