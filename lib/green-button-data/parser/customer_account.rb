module GreenButtonData
  module Parser
    class CustomerAccount
      include SAXMachine

      element :name, as: :account_id

      # Special case for SCE namespacing
      element :'cust:name', as: :account_id
    end
  end
end
