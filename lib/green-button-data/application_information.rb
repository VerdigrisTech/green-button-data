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
                :client_id,
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

    attr_accessor :status

    def initialize(attributes)
      if attributes.is_a?(Hash)
        @data_custodian_id = attributes[:data_custodian_id]
        @data_custodian_application_status = attributes[:data_custodian_application_status]
        @data_custodian_scope_selection_screen_uri = attributes[:data_custodian_scope_selection_screen_uri]
        @data_custodian_bulk_request_uri = attributes[:data_custodian_bulk_request_uri]
        @data_custodian_resource_endpoint = attributes[:data_custodian_resource_endpoint]
        @third_party_application_type = attributes[:third_party_application_type]
        @third_party_application_use = attributes[:third_party_application_use]
        @third_party_application_description = attributes[:third_party_application_description]
        @third_party_phone = attributes[:third_party_phone]
        @third_party_scope_selection_screen_uri = attributes[:third_party_scope_selection_screen_uri]
        @third_party_user_portal_screen_uri = attributes[:third_party_user_portal_screen_uri]
        @third_party_notify_uri = attributes[:third_party_notify_uri]
        @authorization_server_uri = attributes[:authorization_server_uri]
        @authorization_server_authorization_endpoint = attributes[:authorization_server_authorization_endpoint]
        @authorization_server_registration_endpoint = attributes[:authorization_server_registration_endpoint]
        @authorization_server_token_endpoint = attributes[:authorization_server_token_endpoint]
        @token_endpoint_auth_method = attributes[:token_endpoint_auth_method]
        @client_name = attributes[:client_name]
        @client_id = attributes[:client_id]
        @client_secret = attributes[:client_secret]
        @client_id_issued_at = attributes[:client_id_issued_at]
        @client_secret_expires_at = attributes[:client_secret_expires_at]
        @redirect_uri = attributes[:redirect_uri]
        @software_id = attributes[:software_id]
        @software_version = attributes[:software_version]
        @contacts = attributes[:contacts]
        @scopes = attributes[:scopes]
        @grant_types = attributes[:grant_types]
        @response_types = attributes[:response_types]
        @registration_client_uri = attributes[:registration_client_uri]
        @registration_access_token = attributes[:registration_access_token]
      elsif attributes.is_a?(GreenButtonData::Parser::ApplicationInformation)
        @data_custodian_id = attributes.data_custodian_id
        @data_custodian_application_status = attributes.application_status
        @data_custodian_scope_selection_screen_uri = attributes.data_custodian_scope_selection_screen_uri
        @data_custodian_bulk_request_uri = attributes.data_custodian_bulk_request_uri
        @data_custodian_resource_endpoint = attributes.data_custodian_resource_endpoint
        @third_party_application_type = attributes.application_type
        @third_party_application_use = attributes.application_use
        @third_party_application_description = attributes.third_party_application_description
        @third_party_phone = attributes.third_party_phone
        @third_party_scope_selection_screen_uri = attributes.third_party_scope_selection_screen_uri
        @third_party_user_portal_screen_uri = attributes.third_party_user_portal_screen_uri
        @third_party_notify_uri = attributes.third_party_notify_uri
        @authorization_server_uri = attributes.authorization_server_uri
        @authorization_server_authorization_endpoint = attributes.authorization_server_authorization_endpoint
        @authorization_server_registration_endpoint = attributes.authorization_server_registration_endpoint
        @authorization_server_token_endpoint = attributes.authorization_server_token_endpoint
        @token_endpoint_auth_method = attributes.token_endpoint_auth_method
        @client_name = attributes.client_name
        @client_id = attributes.client_id
        @client_secret = attributes.client_secret
        @client_id_issued_at = attributes.client_id_issued_at
        @client_secret_expires_at = attributes.client_secret_expires_at
        @redirect_uri = attributes.redirect_uri
        @software_id = attributes.software_id
        @software_version = attributes.software_version
        @contacts = attributes.contacts
        @scopes = attributes.scopes
        @grant_types = attributes.grant_types
        @response_types = attributes.response_types
        @registration_client_uri = attributes.registration_client_uri
        @registration_access_token = attributes.registration_access_token
      end
    end

    def self.get(url = nil, options = nil)
      @url = url or raise ArgumentError "url is required to fetch data"
      @token = options[:token]
      @client_ssl = options[:client_ssl]

      @connection_options = {}
      @connection_options.ssl = @client_ssl if @client_ssl

      conn = Faraday.new @connection_options
      conn.token_auth(@token) if @token

      response = conn.get(@url)

      application_information = if response.status == 200
        feed = GreenButtonData::Parser::Feed.parse response.body
        info = find_application_information(feed) or raise "invalid response"

        self.new info
      else
        self.new
      end

      application_information.status = response.status
      application_information
    end

    def self.find_application_information(feed)
      application_information = nil

      feed.entries.each do |entry|
        if entry.self.downcase =~ /applicationinformation/
          application_information = entry.content.application_information
        end
      end

      application_information
    end
  end
end
