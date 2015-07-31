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
      element :'espi:numerator', class: Integer
      element :'espi:denominator', class: Integer

      # Special case for PG&E which uses generic namespacing
      element :'ns0:numerator', class: Integer
      element :'ns0:denominator', class: Integer
      element :'ns1:numerator', class: Integer
      element :'ns1:denominator', class: Integer
    end
  end
end
