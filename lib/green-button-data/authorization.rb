module GreenButtonData
  class Authorization < GreenButtonData::Model
    def initialize(attributes)
      if attributes.is_a?(Hash)
        @authorized_period = attributes[:authorized_period]
        @published_period = attributes[:published_period]
        @expires_at = attributes[:expires_at]
        @status = attributes[:status]
        @resource_uri = attributes[:resource_uri]
        @authorization_uri = attributes[:authorization_uri]
      elsif attributes.is_a?(GreenButtonData::Parser:Authorization)
        @authorized_period = attributes.authorized_period
        @published_period = attributes.published_period
        @expires_at = attributes.expires_at
        @status = attributes.status
        @resource_uri = attributes.resource_uri
        @authorization_uri = attributes.authorization_uri
      end
    end

    def self.get(url = nil, options = nil)
      @url = url or raise ArgumentError "url is require to fetch data"
      @token = options[:token]
      @client_ssl = options[:client_ssl]

      @connection_options = {}
      @connection_options.ssl = @client_ssl if @client_ssl

      conn = Faraday.new @connection_options
      conn.token_auth(@token) if @token
    end
  end
end
