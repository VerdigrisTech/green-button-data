require "spec_helper"

describe GreenButtonData::Parser::ApplicationInformation do
  context "espi namespace" do
    let(:feed) { GreenButtonData::Feed }
    let :application_information do
      feed.parse(espi_application_information)
          .entries
          .first
          .content
          .application_information
    end

    subject { application_information }

    it "should parse data custodian id" do
      expect(subject.data_custodian_id).to eq "data_custodian"
    end

    it "should parse data custodian application status" do
      expect(subject.data_custodian_application_status).to eq 1
    end

    it "should parse data custodian scope selection URI" do
      expect(subject.data_custodian_scope_selection_screen_uri).to eq "https://services.greenbuttondata.org//DataCustodian/RetailCustomer/ScopeSelectionList?ThirdPartyID=third_party"
    end

    it "should parse data custodian bulk request URI" do
      expect(subject.data_custodian_bulk_request_uri).to eq "https://services.greenbuttondata.org//DataCustodian/espi/1_1/resource/Batch/Bulk"
    end

    it "should parse data custodian resource endpoint" do
      expect(subject.data_custodian_resource_endpoint).to eq "https://services.greenbuttondata.org//DataCustodian/espi/1_1/resource"
    end

    it "should parse third party application type" do
      expect(subject.third_party_application_type).to eq 1
    end

    it "should parse third party application use" do
      expect(subject.third_party_application_use).to eq 1
    end

    it "should parse third party application description" do
      expect(subject.third_party_application_description).to eq "EnergyOS OpenESPI Example Third Party"
    end

    it "should parse third party scope selection URI" do
      expect(subject.third_party_scope_selection_screen_uri).to eq "https://services.greenbuttondata.org/ThirdParty/RetailCustomer/ScopeSelection"
    end

    it "should parse third party user portal URI" do
      expect(subject.third_party_user_portal_screen_uri).to eq "https://services.greenbuttondata.org/ThirdParty"
    end

    it "should parse third party notify URI" do
      expect(subject.third_party_notify_uri).to eq "https://services.greenbuttondata.org/ThirdParty/espi/1_1/Notification"
    end

    it "should parse authorization server URI" do
      expect(subject.authorization_server_uri).to eq "https://services.greenbuttondata.org//DataCustodian/"
    end

    it "should parse authorization server's authorization endpoint" do
      expect(subject.authorization_server_authorization_endpoint).to eq "https://services.greenbuttondata.org//DataCustodian/oauth/authorize"
    end

    it "should parse authorization server's registration endpoint" do
      expect(subject.authorization_server_registration_endpoint).to eq "https://services.greenbuttondata.org//DataCustodian/espi/1_1/register"
    end

    it "should parse authorization server's token endpoint" do
      expect(subject.authorization_server_token_endpoint).to eq "https://services.greenbuttondata.org//DataCustodian/oauth/token"
    end

    it "should parse token endpoint's authentication method" do
      expect(subject.token_endpoint_auth_method).to eq "client_secret_basic"
    end

    it "should parse client name" do
      expect(subject.client_name).to eq "Green Button Third Party"
    end

    it "should parse client id" do
      expect(subject.client_id).to eq "third_party"
    end

    it "should parse client secret" do
      expect(subject.client_secret).to eq "secret"
    end

    it "should parse date when client ID was issued" do
      expect(subject.client_id_issued_at).to eq 1403190000
    end

    it "should parse when client secret expires" do
      expect(subject.client_secret_expires_at).to eq 0
    end

    it "should parse redirect URI" do
      expect(subject.redirect_uri).to eq "https://services.greenbuttondata.org/ThirdParty/espi/1_1/OAuthCallBack"
    end

    it "should parse software id" do
      expect(subject.software_id).to eq "EnergyOS OpenESPI Example Third Party"
    end

    it "should parse software version" do
      expect(subject.software_version).to eq "1.2"
    end

    it "should parse scopes" do
      expect(subject.scopes.size).to eq 3
      expect(subject.scopes.first).to eq "FB=1_3_4_5_13_14_39;IntervalDuration=3600;BlockDuration=monthly;HistoryLength=13"
      expect(subject.scopes.last).to eq "FB=1_3_4_5_6_7_8_9_10_11_29_12_13_14_15_16_17_18_19_27_28_32_33_34_35_37_38_39_40_41_44;IntervalDuration=3600;BlockDuration=monthly;HistoryLength=13"
    end

    it "should parse grant types" do
      expect(subject.grant_types.size).to eq 3
      expect(subject.grant_types.first).to eq "authorization_code"
    end

    it "should parse response types" do
      expect(subject.response_types.size).to eq 1
      expect(subject.response_types.first).to eq "token"
    end

    it "should parse registration_client_uri" do
      expect(subject.registration_client_uri).to eq "https://services.greenbuttondata.org//DataCustodian/espi/1_1/resource/ApplicationInformation/2"
    end

    it "should parse registration_access_token" do
      expect(subject.registration_access_token).to eq "d89bb056-0f02-4d47-9fd2-ec6a19ba8d0c"
    end

    describe "#application_status" do
      it "should return application status as a symbol" do
        expect(subject.application_status).to eq :review
      end
    end

    describe "#application_type" do
      it "should return application type as a symbol" do
        expect(subject.application_type).to eq :web
      end
    end

    describe "#application_use" do
      it "should return application use as a symbol" do
        expect(subject.application_use).to eq :energy_management
      end
    end
  end

  context "PG&E namespace" do
    let(:feed) { GreenButtonData::Feed }
    let :application_information do
      feed.parse(pge_application_information)
          .entries
          .first
          .content
          .application_information
    end

    subject { application_information }

    it "should parse data custodian id" do
      expect(subject.data_custodian_id).to eq "PGE"
    end

    it "should parse data custodian application status" do
      expect(subject.data_custodian_application_status).to eq 2
    end

    it "should parse data custodian scope selection URI" do
      expect(subject.data_custodian_scope_selection_screen_uri).to eq "https://sharemydata.pge.com/myAuthorization/?clientId=0&verified=true"
    end

    it "should parse data custodian bulk request URI" do
      expect(subject.data_custodian_bulk_request_uri).to eq "https://api.pge.com/GreenButtonConnect/espi/1_1/resource/Batch/Bulk/0"
    end

    it "should parse data custodian resource endpoint" do
      expect(subject.data_custodian_resource_endpoint).to eq "https://api.pge.com/GreenButtonConnect/espi/1_1/resource"
    end

    it "should parse third party application type" do
      expect(subject.third_party_application_type).to eq 1
    end

    it "should parse third party application use" do
      expect(subject.third_party_application_use).to eq nil
    end

    it "should parse third party application description" do
      expect(subject.third_party_application_description).to eq "Verdigris is an energy intelligence solution that shows facilities managers how their buildings use energy at the equipment level--all in real time."
    end

    it "should parse third party phone number" do
      expect(subject.third_party_phone).to eq "6502273888"
    end

    it "should parse third party scope selection URI" do
      expect(subject.third_party_scope_selection_screen_uri).to eq "http://api.example.com/espi/pge"
    end

    it "should parse third party user portal URI" do
      expect(subject.third_party_user_portal_screen_uri).to eq "https://www.example.com"
    end

    it "should parse third party notify URI" do
      expect(subject.third_party_notify_uri).to eq "https://api.example.com/espi/pge/notify"
    end

    it "should parse authorization server URI" do
      expect(subject.authorization_server_uri).to eq "https://api.pge.com"
    end

    it "should parse authorization server's authorization endpoint" do
      expect(subject.authorization_server_authorization_endpoint).to eq "https://api.pge.com/datacustodian/oauth/v2/authorize"
    end

    it "should parse authorization server's registration endpoint" do
      expect(subject.authorization_server_registration_endpoint).to eq nil
    end

    it "should parse authorization server's token endpoint" do
      expect(subject.authorization_server_token_endpoint).to eq "https://api.pge.com/datacustodian/oauth/v2/token"
    end

    it "should parse token endpoint's authentication method" do
      expect(subject.token_endpoint_auth_method).to eq "client_secret_basic"
    end

    it "should parse client name" do
      expect(subject.client_name).to eq "Verdigris Technologies, Inc."
    end

    it "should parse client id" do
      expect(subject.client_id).to eq "verdigris"
    end

    it "should parse client secret" do
      expect(subject.client_secret).to eq "foobar"
    end

    it "should parse date when client ID was issued" do
      expect(subject.client_id_issued_at).to eq 1445444481075
    end

    it "should parse when client secret expires" do
      expect(subject.client_secret_expires_at).to eq 0
    end

    it "should parse redirect URI" do
      expect(subject.redirect_uri).to eq "http://api.example.com/espi/pge/callback"
    end

    it "should parse software id" do
      expect(subject.software_id).to eq "NA"
    end

    it "should parse software version" do
      expect(subject.software_version).to eq "NA"
    end

    it "should parse scopes" do
      expect(subject.scopes.size).to eq 1
      expect(subject.scopes.first).to eq "FB=1_3_4_5_8_13_14_15_18_19_31_32_35_37_38_39_40;IntervalDuration=900_3600;BlockDuration=Daily;HistoryLength=63072000;SubscriptionFrequency=Daily;"
    end

    it "should parse grant types" do
      expect(subject.grant_types.size).to eq 3
      expect(subject.grant_types.first).to eq "authorization_code"
    end

    it "should parse response types" do
      expect(subject.response_types.size).to eq 1
      expect(subject.response_types.first).to eq "code"
    end

    it "should parse registration_client_uri" do
      expect(subject.registration_client_uri).to eq "https://api.pge.com/GreenButtonConnect/espi/1_1/resource/ApplicationInformation/00000000-2222-4444-6666-8888aaaacccc"
    end

    it "should parse registration_access_token" do
      expect(subject.registration_access_token).to eq "00001111-2222-3333-4444-cccceeeeffff"
    end

    describe "#application_status" do
      it "should return application status as a symbol" do
        expect(subject.application_status).to eq :production
      end
    end

    describe "#application_type" do
      it "should return application type as a symbol" do
        expect(subject.application_type).to eq :web
      end
    end

    describe "#application_use" do
      it "should return application use as a symbol" do
        expect(subject.application_use).to eq nil
      end
    end
  end
end
