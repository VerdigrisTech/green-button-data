module GreenButtonData
  module Parser
    class Customer
      include SAXMachine

      element :name
    end
  end
end
