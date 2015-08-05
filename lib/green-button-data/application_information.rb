module GreenButtonData
  class ApplicationInformation
    attr_reader :data_custodian_id,
                :data_custodian_application_status,
                :data_custodian_scope_selection_screen_uri,
                :data_custodian_bulk_request_uri,
                :data_custodian_resource_endpoint,
                :third_party_application_type,
                :third_party_application_use,
                :third_party_application_description,
                :third_party_phone,
                :third_party_scope_selection_screen_uri,
                :third_party_user_portal_screen_uri,
                :third_party_notify_uri,
                :authorization_server_uri,
                :authorization_server_authorization_endpoint,
                :authorization_server_registration_endpoint,
                :authorization_server_token_endpoint,
                :token_endpoint_auth_method,
                :client_name,
                :client_secret,
                :client_id_issued_at,
                :client_secret_expires_at,
                :redirect_uri,
                :software_id,
                :software_version,
                :contacts,
                :scopes,
                :grant_types,
                :response_types,
                :registration_client_uri,
                :registration_access_token

    def self.get(url = nil, options = nil)
      self.new

      @url = url or raise ArgumentError "url is required to fetch data"
      @token = options.token
      @client_ssl = options.client_ssl

      @connection_options = {}
      @connection_options.ssl = @client_ssl if @client_ssl

      conn = Faraday.new @connection_options
      conn.token_auth(@token) if @token

      response = conn.get(@url)

      if response.status == 200
        feed = GreenButtonData::Parser::Feed.parse response.body
        info = find_application_information(feed) or raise Error "invalid response"

        @data_custodian_id = info.data_custodian_id
        @data_custodian_application_status = info.data_custodian_application_status
        @data_custodian_scope_selection_screen_uri = info.data_custodian_scope_selection_screen_uri
        @data_custodian_bulk_request_uri = info.data_custodian_bulk_request_uri
        @data_custodian_resource_endpoint = info.data_custodian_resource_endpoint
        @third_party_application_type = info.third_party_application_type
        @third_party_application_use = info.third_party_application_use
        @third_party_application_description = info.third_party_application_description
        @third_party_phone = info.third_party_phone
        @third_party_scope_selection_screen_uri = info.third_party_scope_selection_screen_uri
        @third_party_user_portal_screen_uri = info.third_party_user_portal_screen_uri
        @third_party_notify_uri = info.third_party_notify_uri
        @authorization_server_uri = info.authorization_server_uri
        @authorization_server_authorization_endpoint = info.authorization_server_authorization_endpoint
        @authorization_server_registration_endpoint = info.authorization_server_registration_endpoint
        @authorization_server_token_endpoint = info.authorization_server_token_endpoint
        @token_endpoint_auth_method = info.token_endpoint_auth_method
        @client_name = info.client_name
        @client_id = info.client_id
        @client_secret = info.client_secret
        @client_id_issued_at = info.client_id_issued_at
        @client_secret_expires_at = info.client_secret_expires_at
        @redirect_uri = info.redirect_uri
        @software_id = info.software_id
        @software_version = info.software_version
        @contacts = info.contacts
        @scopes = info.scopes
        @grant_types = info.grant_types
        @response_types = info.response_types
        @registration_client_uri = info.registration_client_uri
        @registration_access_token = info.registration_access_token
      end
    end

    private
    def find_application_information(feed)
      application_information = nil

      feed.entries.each do |entry|
        if entry.self =~ /applicationinformation/
          application_information = entry.content.application_information
        end
      end

      application_information
    end
  end
end
