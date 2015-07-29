module GreenButtonData
  module Parser
    class Period
      include SAXMachine
      include Utilities

      element :duration, class: Integer { |t| normalize_epoch t }
      element :start, class: Integer { |t| normalize_epoch t }
    end
  end
end
