module GreenButtonData
  module Parser
    class TownDetail
      include SAXMachine

      element :state_or_province, as: :state_or_province
      element :code, as: :code
      element :name, as: :name

      # ESPI Namespacing
      element :'espi:stateOrProvince', as: :state_or_province
      element :'espi:code', as: :code
      element :'espi:name', as: :name

      # Special case for PG&E generic namespacing
      element :'ns0:stateOrProvince', as: :state_or_province
      element :'ns0:code', as: :code
      element :'ns0:name', as: :name
    end
  end
end
