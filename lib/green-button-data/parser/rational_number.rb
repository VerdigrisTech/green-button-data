module GreenButtonData
  module Parser
    class RationalNumber
      include SAXMachine

      element :numerator, class: Integer
      element :denominator, class: Integer

      def to_f
        @numerator / @denominator
      end

      # ESPI Namespacing
      element :'espi:numerator', class: Integer, as: :numerator
      element :'espi:denominator', class: Integer, as: :denominator

      # Special case for PG&E which uses generic namespacing
      element :'ns0:numerator', class: Integer, as: :numerator
      element :'ns0:denominator', class: Integer, as: :denominator
    end
  end
end
