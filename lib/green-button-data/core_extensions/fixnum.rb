module GreenButtonData
  module CoreExtensions
    module Fixnum
      def digits(base = 10)
        num = self.abs
        if num == 0
          1
        else
          Math.log10(num).floor + 1
        end
      end
    end # Fixnum
  end # CoreExtensions
end # GreenButtonData
