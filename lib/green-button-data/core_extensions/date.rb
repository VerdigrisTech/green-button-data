module GreenButtonData
  module CoreExtensions
    module Date
      def utc
        self.new_offset(0)
      end

      def local
        new_offset(DateTime.now.offset - offset)
      end
    end # Date
  end # CoreExtensions
end # GreenButtonData
