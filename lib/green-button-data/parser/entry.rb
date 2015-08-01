module GreenButtonData
  module Parser
    class Entry
      include SAXMachine
      include Utilities

      element :id, as: :entry_id

      def id
        @entry_id ||= @self
      end

      element :link, as: :up, value: :href, with: { rel: 'up' }
      element :link, as: :self, value: :href, with: { rel: 'self' }
      element :link, as: :related, value: :href, with: { rel: 'related' }

      element :content, class: Content, as: :content

      # Published Date
      element :published

      def published
        @published ||= @updated
      end

      def published=(val)
        @published = parse_datetime val
      end

      # Updated Date
      element :updated

      def updated=(val)
        @updated = parse_datetime val
      end

      # Handle PG&E namespacing
      element :'ns1:id', as: :entry_id
      element :'ns1:link', as: :up, value: :href, with: { rel: 'up' }
      element :'ns1:link', as: :self, value: :href, with: { rel: 'self' }
      element :'ns1:link', as: :related, value: :href, with: { rel: 'related' }
      element :'ns1:content', class: Content, as: :content
      element :'ns1:published', as: :published
      element :'ns1:updated', as: :updated
    end
  end
end
