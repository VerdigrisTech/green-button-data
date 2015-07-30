module GreenButtonData
  module Parser
    class ApplicationInformation
      include SAXMachine
      include Utilities

      # Data Custodian
      element :dataCustodianId, as: :data_custodian_id
      element :dataCustodianApplicationStatus,
              as: :data_custodian_application_status
      element :dataCustodianScopeSelectionUri,
              as: :data_custodiwn_scope_selection_uri
      element :dataCustodianBulkRequestUri,
              as: :data_custodian_bulk_request_uri
      element :dataCustodianResourceEndpoint,
              as: :data_custodian_resource_endpoint

      # Third Party
      element :thirdPartyApplicationType, as: :third_party_application_type
      element :thirdPartyApplicationUse, as: :third_party_application_use
      element :thirdPartyApplicationDescription,
              as: :third_party_application_description
      element :thirdPartyPhone, as: :third_party_phone
      element :thirdPartyScopeSelectionUri, as: :third_party_scope_selection_uri
      element :thirdPartyUserPortalScreenUri,
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
        Time.at(normalize_epoch(epoch)).utc.to_datetime
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

      # ESPI Namespacing
      element :'espi:dataCustodianId', as: :data_custodian_id
      element :'espi:dataCustodianApplicationStatus',
              as: :data_custodian_application_status
      element :'espi:dataCustodianScopeSelectionUri',
              as: :data_custodiwn_scope_selection_uri
      element :'espi:dataCustodianBulkRequestUri',
              as: :data_custodian_bulk_request_uri
      element :'espi:dataCustodianResourceEndpoint',
              as: :data_custodian_resource_endpoint
      element :'espi:thirdPartyApplicationType',
              as: :third_party_application_type
      element :'espi:thirdPartyApplicationUse', as: :third_party_application_use
      element :'espi:thirdPartyApplicationDescription',
              as: :third_party_application_description
      element :'espi:thirdPartyPhone', as: :third_party_phone
      element :'espi:thirdPartyScopeSelectionUri',
              as: :third_party_scope_selection_uri
      element :'espi:thirdPartyUserPortalScreenUri',
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
      element :'ns0:dataCustodianApplicationStatus',
              as: :data_custodian_application_status
      element :'ns0:dataCustodianScopeSelectionUri',
              as: :data_custodiwn_scope_selection_uri
      element :'ns0:dataCustodianBulkRequestUri',
              as: :data_custodian_bulk_request_uri
      element :'ns0:dataCustodianResourceEndpoint',
              as: :data_custodian_resource_endpoint
      element :'ns0:thirdPartyApplicationType',
              as: :third_party_application_type
      element :'ns0:thirdPartyApplicationUse', as: :third_party_application_use
      element :'ns0:thirdPartyApplicationDescription',
              as: :third_party_application_description
      element :'ns0:thirdPartyPhone', as: :third_party_phone
      element :'ns0:thirdPartyScopeSelectionUri',
              as: :third_party_scope_selection_uri
      element :'ns0:thirdPartyUserPortalScreenUri',
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
      element :'ns1:dataCustodianId', as: :data_custodian_id
      element :'ns1:dataCustodianApplicationStatus',
              as: :data_custodian_application_status
      element :'ns1:dataCustodianScopeSelectionUri',
              as: :data_custodiwn_scope_selection_uri
      element :'ns1:dataCustodianBulkRequestUri',
              as: :data_custodian_bulk_request_uri
      element :'ns1:dataCustodianResourceEndpoint',
              as: :data_custodian_resource_endpoint
      element :'ns1:thirdPartyApplicationType',
              as: :third_party_application_type
      element :'ns1:thirdPartyApplicationUse', as: :third_party_application_use
      element :'ns1:thirdPartyApplicationDescription',
              as: :third_party_application_description
      element :'ns1:thirdPartyPhone', as: :third_party_phone
      element :'ns1:thirdPartyScopeSelectionUri',
              as: :third_party_scope_selection_uri
      element :'ns1:thirdPartyUserPortalScreenUri',
              as: :third_party_user_portal_screen_uri
      element :'ns1:thirdPartyNotifyUri', as: :third_party_notify_uri
      element :'ns1:authorizationServerUri', as: :authorization_server_uri
      element :'ns1:authorizationServerAuthorizationEndpoint',
              as: :authorization_server_authorization_endpoint
      element :'ns1:authorizationServerRegistrationEndpoint',
              as: :authorization_server_registration_endpoint
      element :'ns1:authorizationServerTokenEndpoint',
              as: :authorization_server_token_endpoint
      element :'ns1:token_endpoint_auth_method',
              as: :token_endpoint_auth_method
      element :'ns1:client_name', as: :client_name
      element :'ns1:client_id', as: :client_id
      element :'ns1:client_secret', as: :client_secret
      element :'ns1:client_id_issued_at', class: Integer,
              as: :client_id_issued_at
      element :'ns1:client_secret_expires_at', class: Integer,
              as: :client_secret_expires_at
      element :'ns1:redirect_uri', as: :redirect_uri
      element :'ns1:software_id', as: :software_id
      element :'ns1:software_version', as: :software_version
      element :'ns1:contacts', as: :contacts
      element :'ns1:scope', as: :scope
      element :'ns1:grant_types', as: :grant_types
      element :'ns1:response_types', as: :response_types
      element :'ns1:registration_client_uri', as: :registration_client_uri
      element :'ns1:registration_access_token', as: :registration_access_token
    end
  end
end
