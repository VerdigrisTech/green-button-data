module GreenButtonData
  module Parser
    class Feed
      include SAXMachine
      include Utilities

      element :id, as: :feed_id

      def id
        @feed_id ||= @feed_url
      end

      element :title
      element :subtitle, as: :description

      element :link, as: :url, value: :href, with: { type: 'text/html' }
      element :link, as: :feed_url, value: :href, with: { rel: 'self' }
      element :link, as: :links, value: :href

      def url
        @url || (links - [feed_url]).last || links.last
      end

      def feed_url
        @feed_url ||= links.first
      end

      elements :entry, class: Entry, as: :entries

      element :updated

      def updated=(val)
        @updated = parse_datetime val
      end

      # PG&E's generic namespace
      element :'ns1:id', as: :feed_id
      element :'ns1:title', as: :title
      element :'ns1:subtitle', as: :description
      element :'ns1:link', as: :url, value: :href, with: { type: 'text/html' }
      element :'ns1:link', as: :feed_url, value: :href, with: { rel: 'self' }
      element :'ns1:links', as: :links, value: :href
      elements :'ns1:entry', class: Entry, as: :entries
      element :'ns1:updated', as: :updated

      element :'ns2:id', as: :feed_id
      element :'ns2:title', as: :title
      element :'ns2:subtitle', as: :description
      element :'ns2:link', as: :url, value: :href, with: { type: 'text/html' }
      element :'ns2:link', as: :feed_url, value: :href, with: { rel: 'self' }
      element :'ns2:links', as: :links, value: :href
      elements :'ns2:entry', class: Entry, as: :entries
      element :'ns2:updated', as: :updated
    end
  end
end
