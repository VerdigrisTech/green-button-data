require "spec_helper"

describe GreenButtonData::Authorization do
  let(:all_url) { GreenButtonData.configuration.authorization_url }
  let :find_url do
    "https://services.greenbuttondata.org/DataCustodian/espi/1_1/resource/Authorization/4"
  end
  let(:token) { "53520584-d640-4812-a721-8a1afa459ff7" }

  subject { GreenButtonData::Authorization }

  before do
    GreenButtonData.configure do |config|
      config.base_url = "https://services.greenbuttondata.org/DataCustodian/" +
                        "espi/1_1/resource/"

      config.authorization_path = "Authorization/"
    end

    stub_request(:get, all_url).to_return status: 200, body: espi_authorization
    stub_request(:get, find_url).to_return status: 200, body: espi_authorization
    stub_request(
      :get, "#{find_url}/"
    ).to_return status: 200, body: espi_authorization
  end

  describe "Constructor" do
    it "should be a valid instance of Authorization" do
      auth = subject.new id: "1", status: :active, authorization_uri: "http://foo"
      expect(auth).to be_a GreenButtonData::Authorization
      expect(auth.id).to eq "1"
      expect(auth.status).to eq :active
      expect(auth.authorization_uri).to eq "http://foo"
      expect(auth.resource_uri).to be_nil
    end
  end

  describe "#all" do
    context "valid authorization" do
      let(:collection) { subject.all(token: token) }

      it "should return a ModelCollection" do
        expect(collection).to be_a GreenButtonData::ModelCollection
      end

      it "should be a collection of GreenButtonData::Authorization instances" do
        expect(collection.first).to be_a GreenButtonData::Authorization
      end

      it "should populate attributes" do
        expect(collection.first.id).to eq "4"
        expect(collection.first.status).to eq :active
        expect(collection.first.resource_uri).to eq "https://services.greenbuttondata.org/DataCustodian/espi/1_1/resource/ApplicationInformation/2"
        expect(collection.first.authorization_uri).to eq "https://services.greenbuttondata.org/DataCustodian/espi/1_1/resource/Authorization/4"
      end
    end
  end

  describe "#find" do
    context "valid authorization" do
      it "is an instance of Authorization" do
        expect(subject.find(4, token: token)).to be_a GreenButtonData::Authorization
        expect(subject.find("https://services.greenbuttondata.org/DataCustodian/espi/1_1/resource/Authorization/4", token: token)).to be_a GreenButtonData::Authorization
      end

      it "should populate attributes" do
        authorization = subject.find(4, token: token)
        expect(authorization.id).to eq "4"
        expect(authorization.status).to eq :active
        expect(authorization.resource_uri).to eq "https://services.greenbuttondata.org/DataCustodian/espi/1_1/resource/ApplicationInformation/2"
        expect(authorization.authorization_uri).to eq "https://services.greenbuttondata.org/DataCustodian/espi/1_1/resource/Authorization/4"
      end
    end
  end

  describe "#first" do
    context "valid authorization" do
      it "should return the first Authorization entry" do
        expect(subject.first(all_url, token: token)).to be_a GreenButtonData::Authorization
      end
    end
  end

  describe "#last" do
    context "valid authorization" do
      it "should return the last Authorization entry" do
        expect(subject.last(all_url, token: token)).to be_a GreenButtonData::Authorization
      end
    end
  end
end
