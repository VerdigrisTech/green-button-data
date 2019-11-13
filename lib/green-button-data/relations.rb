module GreenButtonData
  module Relations

    ##
    # Extracts related URLs from an Entry
    #
    # ==== Arguments
    #
    # * +entry+ - An instance of GreenButtonData::Parser::Entry
    def construct_related_urls(entry)
      related_urls = {}

      entry.related.each do |related_url|
        match_data = /\/(\w+)(\/(\d+))*$/.match(related_url)

        unless match_data.nil?
          related_urls[:"#{match_data[1].underscore}"] = related_url
        end
      end

      related_urls
    end

    def construct_links_hash(entry)
      {
        related: entry.related,
        self: entry.self,
        up: entry.up
      }
    end
  end
end
