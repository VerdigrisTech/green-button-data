module GreenButtonData
  module Parser
    class Authorization
      include SAXMachine
      include Utilities

      element :authorizedPeriod, class: Interval, as: :authorized_period
      element :publishedPeriod, class: Interval, as: :published_period

      element :expires_at, class: Integer do |epoch|
        Time.at(normalize_epoch(epoch)).utc.to_datetime
      end

      element :status, class: Integer

      def active?
        @status > 0
      end

      # TODO: Add scope parser
      element :scope

      element :resourceURI, as: :resource_uri
      element :authorizationURI, as: :authorization_uri

      # ESPI Namespacing
      element :'espi:authorizedPeriod', class: Interval, as: :authorized_period
      element :'espi:publishedPeriod', class: Interval, as: :published_period
      element :'espi:expires_at', class: Integer, as: :expires_at
      element :'espi:status', class: Integer, as: :status
      element :'espi:scope', as: :scope
      element :'espi:resourceURI', as: :resource_uri
      element :'espi:authorizationURI', as: :authorization_uri

      # Special case for PG&E which uses generic namespacing
      element :'ns0:authorizedPeriod', class: Interval, as: :authorized_period
      element :'ns0:publishedPeriod', class: Interval, as: :published_period
      element :'ns0:expires_at', class: Integer, as: :expires_at
      element :'ns0:status', class: Integer, as: :status
      element :'ns0:scope', as: :scope
      element :'ns0:resourceURI', as: :resource_uri
      element :'ns0:authorizationURI', as: :authorization_uri
    end
  end
end
