module GreenButtonData
  module Parser
    class ServiceCategory
      include SAXMachine

      element :kind, class: Integer do |kind|
        SERVICE_CATEGORY[kind]
      end

      # ESPI Namespacing
      element :'espi:kind', class: Integer, as: :kind

      # Special case for PG&E which uses generic namespacing
      element :'ns0:kind', class: Integer, as: :kind
      element :'ns1:kind', class: Integer, as: :kind
    end
  end
end
