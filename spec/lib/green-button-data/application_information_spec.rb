require "spec_helper"

describe GreenButtonData::ApplicationInformation do
  let(:url) { "https://services.greenbuttondata.org/DataCustodian/espi/1_1/resource/ApplicationInformation/2" }

  describe "#self.get" do
    context "valid authorization" do
      let(:token) { "c66b0854-ea1f-4e24-afb7-afab9e0f6c5e" }

      before do
        stub_request(:get, url).to_return status: 200, body: espi_application_information
      end

      subject { GreenButtonData::ApplicationInformation.get(url, token: token) }

      it "creates an instance of ApplicationInformation" do
        expect(subject).to be_a GreenButtonData::ApplicationInformation
      end

      it "status code is 200" do
        expect(subject.status).to eq 200
      end

      it "should populate data_custodian_id attribute" do
        expect(subject.data_custodian_id).to eq "data_custodian"
      end

      it "should populate data_custodian_application_status attribute" do
        expect(subject.data_custodian_application_status).to eq :review
      end

      it "should populate data_custodian_scope_selection_screen_uri attribute" do
        expect(subject.data_custodian_scope_selection_screen_uri).to eq "https://services.greenbuttondata.org//DataCustodian/RetailCustomer/ScopeSelectionList?ThirdPartyID=third_party"
      end

      it "should populate data_custodian_bulk_request_uri attribute" do
        expect(subject.data_custodian_bulk_request_uri).to eq "https://services.greenbuttondata.org//DataCustodian/espi/1_1/resource/Batch/Bulk"
      end

      it "should populate data_custodian_resource_endpoint attribute" do
        expect(subject.data_custodian_resource_endpoint).to eq "https://services.greenbuttondata.org//DataCustodian/espi/1_1/resource"
      end

      it "should populate third_party_application_type attribute" do
        expect(subject.third_party_application_type).to eq :web
      end

      it "should populate third_party_application_use attribute" do
        expect(subject.third_party_application_use).to eq :energy_management
      end

      it "should populate third_party_application_description attribute" do
        expect(subject.third_party_application_description).to eq "EnergyOS OpenESPI Example Third Party"
      end

      it "should populate third_party_scope_selection_screen_uri attribute" do
        expect(subject.third_party_scope_selection_screen_uri).to eq "https://services.greenbuttondata.org/ThirdParty/RetailCustomer/ScopeSelection"
      end

      it "should populate third_party_user_portal_screen_uri attribute" do
        expect(subject.third_party_user_portal_screen_uri).to eq "https://services.greenbuttondata.org/ThirdParty"
      end

      it "should populate third_party_notify_uri attribute" do
        expect(subject.third_party_notify_uri).to eq "https://services.greenbuttondata.org/ThirdParty/espi/1_1/Notification"
      end

      it "should populate authorization_server_uri attribute" do
        expect(subject.authorization_server_uri).to eq "https://services.greenbuttondata.org//DataCustodian/"
      end

      it "should populate authorization_server_authorization_endpoint attribute" do
        expect(subject.authorization_server_authorization_endpoint).to eq "https://services.greenbuttondata.org//DataCustodian/oauth/authorize"
      end

      it "should populate authorization_server_registration_endpoint attribute" do
        expect(subject.authorization_server_registration_endpoint).to eq "https://services.greenbuttondata.org//DataCustodian/espi/1_1/register"
      end

      it "should populate authorization_server_token_endpoint attribute" do
        expect(subject.authorization_server_token_endpoint).to eq "https://services.greenbuttondata.org//DataCustodian/oauth/token"
      end

      it "should populate token_endpoint_auth_method attribute" do
        expect(subject.token_endpoint_auth_method).to eq "client_secret_basic"
      end

      it "should populate client_name attribute" do
        expect(subject.client_name).to eq "Green Button Third Party"
      end

      it "should populate client_id attribute" do
        expect(subject.client_id).to eq "third_party"
      end

      it "should populate client_secret attribute" do
        expect(subject.client_secret).to eq "secret"
      end

      it "should populate client_id_issued_at attribute" do
        expect(subject.client_id_issued_at).to eq DateTime.new 2014, 6, 19, 15
      end

      it "should populate client_secret_expires_at attribute" do
        expect(subject.client_secret_expires_at).to eq DateTime.new 9999, 12, 31, 23, 59, 59
      end

      it "should populate redirect_uri attribute" do
        expect(subject.redirect_uri).to eq "https://services.greenbuttondata.org/ThirdParty/espi/1_1/OAuthCallBack"
      end

      it "should populate software_id attribute" do
        expect(subject.software_id).to eq "EnergyOS OpenESPI Example Third Party"
      end

      it "should populate software_version attribute" do
        expect(subject.software_version).to eq "1.2"
      end

      it "should populate scopes attribute" do
        expect(subject.scopes).not_to be_empty
      end

      it "should populate grant_types attribute" do
        expect(subject.grant_types).not_to be_empty
      end

      it "should populate response_types attribute" do
        expect(subject.response_types).not_to be_empty
      end

      it "should populate registration_client_uri attribute" do
        expect(subject.registration_client_uri).to eq "https://services.greenbuttondata.org//DataCustodian/espi/1_1/resource/ApplicationInformation/2"
      end

      it "should populate registration_access_token attribute" do
        expect(subject.registration_access_token).to eq "d89bb056-0f02-4d47-9fd2-ec6a19ba8d0c"
      end
    end
  end
end
