module GreenButtonData
  class Feed
    def self.fetch(url, options)
      block = block_given? ? Proc.new : nil
      conn = Faraday.new url, options, &block
    end

    def self.parse(xml)
      GreenButtonData::Parser::Feed.parse xml
    end
  end
end
