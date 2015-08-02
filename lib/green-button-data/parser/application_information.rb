module GreenButtonData
  module Parser
    class ApplicationInformation
      include SAXMachine
      include Enumerations
      include Utilities

      # Data Custodian
      element :dataCustodianId, as: :data_custodian_id
      element :dataCustodianApplicationStatus, class: Integer,
              as: :data_custodian_application_status
      element :dataCustodianScopeSelectionScreenURI,
              as: :data_custodian_scope_selection_screen_uri
      element :dataCustodianBulkRequestURI,
              as: :data_custodian_bulk_request_uri
      element :dataCustodianResourceEndpoint,
              as: :data_custodian_resource_endpoint

      # Third Party
      element :thirdPartyApplicationType, class: Integer,
              as: :third_party_application_type
      element :thirdPartyApplicationUse, class: Integer,
              as: :third_party_application_use
      element :thirdPartyApplicationDescription,
              as: :third_party_application_description
      element :thirdPartyPhone, as: :third_party_phone
      element :thirdPartyScopeSelectionScreenURI,
              as: :third_party_scope_selection_screen_uri
      element :thirdPartyUserPortalScreenURI,
              as: :third_party_user_portal_screen_uri
      element :thirdPartyNotifyUri, as: :third_party_notify_uri

      # Authorization Information
      element :authorizationServerUri, as: :authorization_server_uri
      element :authorizationServerAuthorizationEndpoint,
              as: :authorization_server_authorization_endpoint
      element :authorizationServerRegistrationEndpoint,
              as: :authorization_server_registration_endpoint
      element :authorizationServerTokenEndpoint,
              as: :authorization_server_token_endpoint
      element :token_endpoint_auth_method

      # Client Information
      element :client_name
      element :client_id
      element :client_secret
      element :client_id_issued_at, class: Integer do |epoch|
        Time.at(normalize_epoch(epoch)).utc.to_datetime
      end
      element :client_secret_expires_at, class: Integer do |epoch|
        if epoch == 0
          # 0 means don't expire; set it to distant future
          DateTime.new 9999, 12, 31, 23, 59, 59
        else
          Time.at(normalize_epoch(epoch)).utc.to_datetime
        end
      end
      element :redirect_uri
      element :software_id
      element :software_version
      element :contacts

      element :scope

      element :grant_types
      element :response_types

      element :registration_client_uri
      element :registration_access_token

      def application_status
        DATA_CUSTODIAN_APPLICATION_STATUS[@data_custodian_application_status]
      end

      def application_type
        THIRD_PARTY_APPLICATION_TYPE[@third_party_application_type]
      end

      def application_use
        THIRD_PARTY_APPLICATION_USE[@third_party_application_use]
      end

      # ESPI Namespacing
      element :'espi:dataCustodianId', as: :data_custodian_id
      element :'espi:dataCustodianApplicationStatus', class: Integer,
              as: :data_custodian_application_status
      element :'espi:dataCustodianScopeSelectionScreenURI',
              as: :data_custodian_scope_selection_screen_uri
      element :'espi:dataCustodianBulkRequestURI',
              as: :data_custodian_bulk_request_uri
      element :'espi:dataCustodianResourceEndpoint',
              as: :data_custodian_resource_endpoint
      element :'espi:thirdPartyApplicationType', class: Integer,
              as: :third_party_application_type
      element :'espi:thirdPartyApplicationUse', class: Integer,
              as: :third_party_application_use
      element :'espi:thirdPartyApplicationDescription',
              as: :third_party_application_description
      element :'espi:thirdPartyPhone', as: :third_party_phone
      element :'espi:thirdPartyScopeSelectionScreenURI',
              as: :third_party_scope_selection_screen_uri
      element :'espi:thirdPartyUserPortalScreenURI',
              as: :third_party_user_portal_screen_uri
      element :'espi:thirdPartyNotifyUri', as: :third_party_notify_uri
      element :'espi:authorizationServerUri', as: :authorization_server_uri
      element :'espi:authorizationServerAuthorizationEndpoint',
              as: :authorization_server_authorization_endpoint
      element :'espi:authorizationServerRegistrationEndpoint',
              as: :authorization_server_registration_endpoint
      element :'espi:authorizationServerTokenEndpoint',
              as: :authorization_server_token_endpoint
      element :'espi:token_endpoint_auth_method',
              as: :token_endpoint_auth_method
      element :'espi:client_name', as: :client_name
      element :'espi:client_id', as: :client_id
      element :'espi:client_secret', as: :client_secret
      element :'espi:client_id_issued_at', class: Integer,
              as: :client_id_issued_at
      element :'espi:client_secret_expires_at', class: Integer,
              as: :client_secret_expires_at
      element :'espi:redirect_uri', as: :redirect_uri
      element :'espi:software_id', as: :software_id
      element :'espi:software_version', as: :software_version
      element :'espi:contacts', as: :contacts
      element :'espi:scope', as: :scope
      element :'espi:grant_types', as: :grant_types
      element :'espi:response_types', as: :response_types
      element :'espi:registration_client_uri', as: :registration_client_uri
      element :'espi:registration_access_token', as: :registration_access_token

      # Special case for PG&E which uses generic namespacing
      element :'ns0:dataCustodianId', as: :data_custodian_id
      element :'ns0:dataCustodianApplicationStatus', class: Integer,
              as: :data_custodian_application_status
      element :'ns0:dataCustodianScopeSelectionScreenURI',
              as: :data_custodian_scope_selection_screen_uri
      element :'ns0:dataCustodianBulkRequestURI',
              as: :data_custodian_bulk_request_uri
      element :'ns0:dataCustodianResourceEndpoint',
              as: :data_custodian_resource_endpoint
      element :'ns0:thirdPartyApplicationType', class: Integer,
              as: :third_party_application_type
      element :'ns0:thirdPartyApplicationUse', class: Integer,
              as: :third_party_application_use
      element :'ns0:thirdPartyApplicationDescription',
              as: :third_party_application_description
      element :'ns0:thirdPartyPhone', as: :third_party_phone
      element :'ns0:thirdPartyScopeSelectionScreenURI',
              as: :third_party_scope_selection_screen_uri
      element :'ns0:thirdPartyUserPortalScreenURI',
              as: :third_party_user_portal_screen_uri
      element :'ns0:thirdPartyNotifyUri', as: :third_party_notify_uri
      element :'ns0:authorizationServerUri', as: :authorization_server_uri
      element :'ns0:authorizationServerAuthorizationEndpoint',
              as: :authorization_server_authorization_endpoint
      element :'ns0:authorizationServerRegistrationEndpoint',
              as: :authorization_server_registration_endpoint
      element :'ns0:authorizationServerTokenEndpoint',
              as: :authorization_server_token_endpoint
      element :'ns0:token_endpoint_auth_method',
              as: :token_endpoint_auth_method
      element :'ns0:client_name', as: :client_name
      element :'ns0:client_id', as: :client_id
      element :'ns0:client_secret', as: :client_secret
      element :'ns0:client_id_issued_at', class: Integer,
              as: :client_id_issued_at
      element :'ns0:client_secret_expires_at', class: Integer,
              as: :client_secret_expires_at
      element :'ns0:redirect_uri', as: :redirect_uri
      element :'ns0:software_id', as: :software_id
      element :'ns0:software_version', as: :software_version
      element :'ns0:contacts', as: :contacts
      element :'ns0:scope', as: :scope
      element :'ns0:grant_types', as: :grant_types
      element :'ns0:response_types', as: :response_types
      element :'ns0:registration_client_uri', as: :registration_client_uri
      element :'ns0:registration_access_token', as: :registration_access_token
    end
  end
end
