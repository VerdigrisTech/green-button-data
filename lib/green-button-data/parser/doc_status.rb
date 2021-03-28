module GreenButtonData
  module Parser
    class DocStatus
      include SAXMachine

      element :value
    end
  end
end
