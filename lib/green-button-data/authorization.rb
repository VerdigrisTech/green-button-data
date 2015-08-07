module GreenButtonData
  class Authorization
    include Fetchable
    include Enumerations

    attr_reader :id

    attr_accessor :authorized_period,
                  :published_period,
                  :expires_at,
                  :status,
                  :resource_uri,
                  :authorization_uri

    def initialize(attributes)
      @id = attributes[:id]
      @authorized_period = attributes[:authorized_period]
      @published_period = attributes[:published_period]
      @expires_at = attributes[:expires_at]

      if attributes[:status].is_a? Numeric
        @status = AUTHORIZATION_STATUS[attributes[:status]]
      elsif attributes[:status].is_a? Symbol
        @status = attributes[:status]
      end

      @resource_uri = attributes[:resource_uri]
      @authorization_uri = attributes[:authorization_uri]
    end
  end
end
