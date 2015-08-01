module GreenButtonData
  module Parser
    class UsagePoint
      include SAXMachine
      include Enumerations

      element :kind, class: Integer

      def service_category
        SERVICE[@kind]
      end

      # ESPI Namespacing
      element :'espi:kind', class: Integer, as: :kind

      # Special case for PG&E which uses generic namespacing
      element :'ns0:kind', class: Integer, as: :kind
    end
  end
end
