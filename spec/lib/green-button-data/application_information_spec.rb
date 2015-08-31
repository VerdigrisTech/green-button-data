require "spec_helper"

describe GreenButtonData::ApplicationInformation do
  let(:all_url) { GreenButtonData.configuration.application_information_url }
  let(:find_url) { "#{all_url}/2" }
  let(:token) { "c66b0854-ea1f-4e24-afb7-afab9e0f6c5e" }

  subject { GreenButtonData::ApplicationInformation }

  let(:application_information) { subject.find(2, token: token) }

  let :authorization_server_authorization_endpoint do
    "https://services.greenbuttondata.org//DataCustodian/oauth/authorize"
  end

  let :authorization_server_registration_endpoint do
    "https://services.greenbuttondata.org//DataCustodian/espi/1_1/register"
  end

  let :authorization_server_token_endpoint do
    "https://services.greenbuttondata.org//DataCustodian/oauth/token"
  end

  let :authorization_server_uri do
    "https://services.greenbuttondata.org//DataCustodian/"
  end

  let(:client_id) { "third_party" }
  let(:client_id_issued_at) { Time.at(1403190000) }
  let(:client_name) { "Green Button Third Party" }
  let(:client_secret) { "secret" }
  let(:client_secret_expires_at) { Time.at(2 ** (0.size * 8 - 2) - 1) }

  let :contacts do
    "john.teeter@energyos.org," +
    "martin.burns@nist.gov," +
    "donald.coffin@reminetworks.com"
  end

  let(:data_custodian_application_status) { :review }

  let :data_custodian_bulk_request_uri do
    "https://services.greenbuttondata.org//DataCustodian/espi/1_1/resource/" +
    "Batch/Bulk"
  end

  let(:data_custodian_id) { "data_custodian" }

  let :data_custodian_resource_endpoint do
    "https://services.greenbuttondata.org//DataCustodian/espi/1_1/resource"
  end

  let :data_custodian_scope_selection_screen_uri do
    "https://services.greenbuttondata.org//DataCustodian/RetailCustomer/" +
    "ScopeSelectionList?ThirdPartyID=third_party"
  end

  let :grant_types do
    [
      "authorization_code",
      "client_credentials",
      "refresh_token"
    ]
  end

  let :redirect_uri do
    "https://services.greenbuttondata.org/ThirdParty/espi/1_1/OAuthCallBack"
  end

  let(:registration_access_token) { "d89bb056-0f02-4d47-9fd2-ec6a19ba8d0c" }

  let :registration_client_uri do
    "https://services.greenbuttondata.org//DataCustodian/espi/1_1/resource/" +
    "ApplicationInformation/2"
  end

  let(:response_types) { ["token"] }

  let :scopes do
    [
      "FB=1_3_4_5_13_14_39;IntervalDuration=3600;BlockDuration=monthly;" +
      "HistoryLength=13",
      "FB=1_3_4_5_13_14_15_39;IntervalDuration=900;BlockDuration=monthly;" +
      "HistoryLength=13",
      "FB=1_3_4_5_6_7_8_9_10_11_29_12_13_14_15_16_17_18_19_27_28_32_33_34_35_" +
      "37_38_39_40_41_44;IntervalDuration=3600;BlockDuration=monthly;" +
      "HistoryLength=13"
    ]
  end

  let(:software_id) { "EnergyOS OpenESPI Example Third Party" }
  let(:software_version) { "1.2" }

  let :third_party_application_description do
    "EnergyOS OpenESPI Example Third Party"
  end

  let(:third_party_application_type) { :web }
  let(:third_party_application_use) { :energy_management }

  let :third_party_notify_uri do
    "https://services.greenbuttondata.org/ThirdParty/espi/1_1/Notification"
  end

  let :third_party_scope_selection_screen_uri do
    "https://services.greenbuttondata.org/ThirdParty/RetailCustomer/" +
    "ScopeSelection"
  end

  let :third_party_user_portal_screen_uri do
    "https://services.greenbuttondata.org/ThirdParty"
  end

  let(:token_endpoint_auth_method) { "client_secret_basic" }

  before do
    GreenButtonData.configure do |config|
      config.base_url                     = "https://services.greenbuttondata" +
                                            ".org/"
      config.application_information_path = "DataCustodian/espi/1_1/resource/" +
                                            "ApplicationInformation/"
    end

    stub_request(:get, all_url).to_return status: 200, body: espi_application_information
    stub_request(:get, find_url).to_return status: 200, body: espi_application_information
  end

  describe "Constructor" do
    it "should be a valid instance of ApplicationInformation" do
      application_information = subject.new id: "1"
      expect(application_information).to be_a subject
      expect(application_information.id).to eq "1"
    end
  end

  describe "#all" do
    context "valid authorization" do
      let(:collection) { subject.all(token: token) }

      it "should return a ModelCollection" do
        expect(collection).to be_a GreenButtonData::ModelCollection
      end

      it "should be a collection of GreenButtonData::ApplicationInformation " +
        "instances" do

        expect(collection.first).to be_a subject
      end

      it "should populate attributes" do
        instance = collection.first
        expect(instance.id).to eq "2"
        expect(instance.data_custodian_id).to eq data_custodian_id

        expect(
          instance.data_custodian_application_status
        ).to eq data_custodian_application_status

        expect(
          instance.data_custodian_scope_selection_screen_uri
        ).to eq data_custodian_scope_selection_screen_uri

        expect(
          instance.data_custodian_bulk_request_uri
        ).to eq data_custodian_bulk_request_uri

        expect(
          instance.data_custodian_resource_endpoint
        ).to eq data_custodian_resource_endpoint

        expect(
          instance.third_party_application_type
        ).to eq third_party_application_type

        expect(
          instance.third_party_application_use
        ).to eq third_party_application_use

        expect(
          instance.third_party_application_description
        ).to eq third_party_application_description

        expect(
          instance.third_party_scope_selection_screen_uri
        ).to eq third_party_scope_selection_screen_uri

        expect(
          instance.third_party_user_portal_screen_uri
        ).to eq third_party_user_portal_screen_uri

        expect(instance.third_party_notify_uri).to eq third_party_notify_uri
        expect(instance.authorization_server_uri).to eq authorization_server_uri

        expect(
          instance.authorization_server_authorization_endpoint
        ).to eq authorization_server_authorization_endpoint

        expect(
          instance.authorization_server_registration_endpoint
        ).to eq authorization_server_registration_endpoint

        expect(
          instance.authorization_server_token_endpoint
        ).to eq authorization_server_token_endpoint

        expect(
          instance.token_endpoint_auth_method
        ).to eq token_endpoint_auth_method

        expect(instance.client_name).to eq client_name
        expect(instance.client_id).to eq client_id
        expect(instance.client_secret).to eq client_secret
        expect(instance.client_id_issued_at).to eq client_id_issued_at
        expect(instance.client_secret_expires_at).to eq client_secret_expires_at
        expect(instance.redirect_uri).to eq redirect_uri
        expect(instance.software_id).to eq software_id
        expect(instance.software_version).to eq software_version
        expect(instance.scopes).to eq scopes
        expect(instance.grant_types).to eq grant_types
        expect(instance.response_types).to eq response_types
        expect(instance.registration_client_uri).to eq registration_client_uri

        expect(
          instance.registration_access_token
        ).to eq registration_access_token
      end
    end
  end

  describe "#find" do
    context "valid authorization" do
      it "is an instance of ApplicationInformation" do
        expect(application_information).to be_a subject
        expect(WebMock).to have_requested(:get, find_url)
      end

      it "should populate attributes" do
        expect(application_information.id).to eq "2"
        expect(
          application_information.data_custodian_id
        ).to eq data_custodian_id

        expect(
          application_information.data_custodian_application_status
        ).to eq data_custodian_application_status

        expect(
          application_information.data_custodian_scope_selection_screen_uri
        ).to eq data_custodian_scope_selection_screen_uri

        expect(
          application_information.data_custodian_bulk_request_uri
        ).to eq data_custodian_bulk_request_uri

        expect(
          application_information.data_custodian_resource_endpoint
        ).to eq data_custodian_resource_endpoint

        expect(
          application_information.third_party_application_type
        ).to eq third_party_application_type

        expect(
          application_information.third_party_application_use
        ).to eq third_party_application_use

        expect(
          application_information.third_party_application_description
        ).to eq third_party_application_description

        expect(
          application_information.third_party_scope_selection_screen_uri
        ).to eq third_party_scope_selection_screen_uri

        expect(
          application_information.third_party_user_portal_screen_uri
        ).to eq third_party_user_portal_screen_uri

        expect(
          application_information.third_party_notify_uri
        ).to eq third_party_notify_uri

        expect(
          application_information.authorization_server_uri
        ).to eq authorization_server_uri

        expect(
          application_information.authorization_server_authorization_endpoint
        ).to eq authorization_server_authorization_endpoint

        expect(
          application_information.authorization_server_registration_endpoint
        ).to eq authorization_server_registration_endpoint

        expect(
          application_information.authorization_server_token_endpoint
        ).to eq authorization_server_token_endpoint

        expect(
          application_information.token_endpoint_auth_method
        ).to eq token_endpoint_auth_method

        expect(application_information.client_name).to eq client_name
        expect(application_information.client_id).to eq client_id
        expect(application_information.client_secret).to eq client_secret

        expect(
          application_information.client_id_issued_at
        ).to eq client_id_issued_at

        expect(
          application_information.client_secret_expires_at
        ).to eq client_secret_expires_at

        expect(application_information.redirect_uri).to eq redirect_uri
        expect(application_information.software_id).to eq software_id
        expect(application_information.software_version).to eq software_version
        expect(application_information.scopes).to eq scopes
        expect(application_information.grant_types).to eq grant_types
        expect(application_information.response_types).to eq response_types

        expect(
          application_information.registration_client_uri
        ).to eq registration_client_uri

        expect(
          application_information.registration_access_token
        ).to eq registration_access_token
      end
    end
  end

  describe "#to_h" do
    it "should return a Hash" do
      expect(application_information.to_h).to be_a Hash
    end

    it "should populate attributes to Hash key values" do
      expect(application_information.to_h).to eq({
        authorization_server_authorization_endpoint:
          authorization_server_authorization_endpoint,
        authorization_server_registration_endpoint:
          authorization_server_registration_endpoint,
        authorization_server_token_endpoint:
          authorization_server_token_endpoint,
        authorization_server_uri: authorization_server_uri,
        client_id: client_id,
        client_id_issued_at: client_id_issued_at,
        client_name: client_name,
        client_secret: client_secret,
        client_secret_expires_at: client_secret_expires_at,
        contacts: contacts,
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
        third_party_phone: nil,
        third_party_scope_selection_screen_uri:
          third_party_scope_selection_screen_uri,
        third_party_user_portal_screen_uri: third_party_user_portal_screen_uri,
        token_endpoint_auth_method: token_endpoint_auth_method
      })
    end
  end
end
