module GreenButtonData
  module Parser
    class StreetDetail
      include SAXMachine

      element :addressGeneral, as: :address_general

      # ESPI Namespacing
      element :'espi:addressGeneral', as: :address_general

      # Special case for PG&E generic namespacing
      element :'ns0:addressGeneral', as: :address_general
    end
  end
end

