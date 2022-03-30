module GreenButtonData
  module Parser
    class StreetDetail
      include SAXMachine

      element :addressGeneral, as: :address_general
      element :name, as: :name
      element :number, as: :number

      # ESPI Namespacing
      element :'espi:addressGeneral', as: :address_general

      # Special case for PG&E generic namespacing
      element :'ns0:addressGeneral', as: :address_general

      # Special case for SCE namespacing
      element :'cust:name', as: :name
      element :'cust:number', as: :number
    end
  end
end

