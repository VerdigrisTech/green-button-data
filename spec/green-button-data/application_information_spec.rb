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
    end
  end
end
