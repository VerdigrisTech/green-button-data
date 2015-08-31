module GreenButtonData
  class ApplicationInformation < Entry
    include Enumerations
    include Utilities

    attr_accessor :authorization_server_authorization_endpoint,
                  :authorization_server_registration_endpoint,
                  :authorization_server_token_endpoint,
                  :authorization_server_uri,
                  :contacts,
                  :client_id,
                  :client_name,
                  :client_secret,
                  :data_custodian_bulk_request_uri,
                  :data_custodian_id,
                  :data_custodian_resource_endpoint,
                  :data_custodian_scope_selection_screen_uri,
                  :grant_types,
                  :redirect_uri,
                  :registration_access_token,
                  :registration_client_uri,
                  :response_types,
                  :scopes,
                  :software_id,
                  :software_version,
                  :third_party_application_description,
                  :third_party_notify_uri,
                  :third_party_phone,
                  :third_party_scope_selection_screen_uri,
                  :third_party_user_portal_screen_uri,
                  :token_endpoint_auth_method

    def client_id_issued_at(kwargs = {})
      epoch_to_time @client_id_issued_at, kwargs
    end

    def client_secret_expires_at(kwargs = {})
      if @client_secret_expires_at == 0
        # Maximum Fixnum = 4611686018427387903
        max_fixnum = 2 ** (@client_secret_expires_at.size * 8 - 2) - 1

        # Roughly 146 billion years into the future; Sun would be long dead by
        # this time; so for all intents and purposes, never expires
        time = Time.at(max_fixnum)

        if kwargs[:local] == true
          return time.localtime
        else
          return time.utc
        end
      else
        epoch_to_time(@client_secret_expires_at, kwargs)
      end
    end

    def data_custodian_application_status
      get_enum_symbol DATA_CUSTODIAN_APPLICATION_STATUS,
                      @data_custodian_application_status
    end

    def third_party_application_type
      get_enum_symbol THIRD_PARTY_APPLICATION_TYPE,
                      @third_party_application_type
    end

    def third_party_application_use
      get_enum_symbol THIRD_PARTY_APPLICATION_USE, @third_party_application_use
    end

    def to_h
      {
        authorization_server_authorization_endpoint:
          authorization_server_authorization_endpoint,
        authorization_server_registration_endpoint:
          authorization_server_registration_endpoint,
        authorization_server_token_endpoint:
          authorization_server_token_endpoint,
        authorization_server_uri: authorization_server_uri,
        contacts: contacts,
        client_id: client_id,
        client_id_issued_at: client_id_issued_at,
        client_name: client_name,
        client_secret: client_secret,
        client_secret_expires_at: client_secret_expires_at,
        data_custodian_application_status: data_custodian_application_status,
        data_custodian_bulk_request_uri: data_custodian_bulk_request_uri,
        data_custodian_id: data_custodian_id,
        data_custodian_resource_endpoint: data_custodian_resource_endpoint,
        data_custodian_scope_selection_screen_uri:
          data_custodian_scope_selection_screen_uri,
        grant_types: grant_types,
        redirect_uri: redirect_uri,
        registration_access_token: registration_access_token,
        registration_client_uri: registration_client_uri,
        response_types: response_types,
        scopes: scopes,
        software_id: software_id,
        software_version: software_version,
        third_party_application_description:
          third_party_application_description,
        third_party_application_type: third_party_application_type,
        third_party_application_use: third_party_application_use,
        third_party_notify_uri: third_party_notify_uri,
        third_party_phone: third_party_phone,
        third_party_scope_selection_screen_uri:
          third_party_scope_selection_screen_uri,
        third_party_user_portal_screen_uri: third_party_user_portal_screen_uri,
        token_endpoint_auth_method: token_endpoint_auth_method
      }
    end
  end
end
