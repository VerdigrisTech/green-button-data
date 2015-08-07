module GreenButtonData
  class Authorization
    include Fetchable

    attr_accessor :authorized_period,
                  :published_period,
                  :expires_at,
                  :status,
                  :resource_uri,
                  :authorization_uri

    def initialize(attributes)
      if attributes.is_a?(Hash)
        @authorized_period = attributes[:authorized_period]
        @published_period = attributes[:published_period]
        @expires_at = attributes[:expires_at]
        @status = attributes[:status]
        @resource_uri = attributes[:resource_uri]
        @authorization_uri = attributes[:authorization_uri]
      elsif attributes.is_a?(GreenButtonData::Parser::Authorization)
        @authorized_period = attributes.authorized_period
        @published_period = attributes.published_period
        @expires_at = attributes.expires_at
        @status = attributes.status
        @resource_uri = attributes.resource_uri
        @authorization_uri = attributes.authorization_uri
      end
    end
  end
end
