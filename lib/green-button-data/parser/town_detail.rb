module GreenButtonData
  module Parser
    class TownDetail
      include SAXMachine

      element :stateOrProvince, as: :state_or_province
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

      # Special case for SCE namespacing
      element :'cust:stateOrProvince', as: :state_or_province
      element :'cust:name', as: :name
    end
  end
end
