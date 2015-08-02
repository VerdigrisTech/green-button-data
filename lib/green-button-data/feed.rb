module GreenButtonData
  class Feed
    def self.parse(xml)
      GreenButtonData::Parser::Feed.parse xml
    end
  end
end
