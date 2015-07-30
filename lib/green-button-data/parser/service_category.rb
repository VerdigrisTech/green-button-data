module GreenButtonData
  module Parser
    class ServiceCategory
      include SAXMachine

      element :kind, class: Integer do |kind|
        SERVICE_CATEGORY[kind]
      end
    end
  end
end
