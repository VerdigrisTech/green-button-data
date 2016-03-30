module GreenButtonData
  module Parser
    class ServiceLocation
      include SAXMachine

      element :main_address, class: MainAddress, as: :main_address

      # ESPI Namespacing
      element :'espi:mainAddress', class: MainAddress, as: :main_address

      # Special case for PG&E generic namespacing
      element :'ns0:mainAddress', class: MainAddress, as: :main_address
    end
  end
end
