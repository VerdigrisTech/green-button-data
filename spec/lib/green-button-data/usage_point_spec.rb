require "spec_helper"

describe GreenButtonData::UsagePoint do
  let(:url) { GreenButtonData.configuration.usage_point_url }
  let(:token) { "53520584-d640-4812-a721-8a1afa459ff7" }

  subject { GreenButtonData::UsagePoint }

  before do
    GreenButtonData.configure do |config|
      config.base_url = "https://services.greenbuttondata.org/"
      config.usage_point_path = "DataCustodian/espi/1_1/resource/UsagePoint"
    end

    stub_request(:get, url).to_return status: 200, body: espi_usage_point
  end

  describe "Constructor" do
    it "should be a valid instance of UsagePoint" do
      usage_point = subject.new id: "1"
      expect(usage_point).to be_a GreenButtonData::UsagePoint
      expect(usage_point.id).to eq "1"
    end
  end

  describe "#all" do
    context "valid authorization" do
      let(:collection) { subject.all(token: token) }

      it "should return a ModelCollection" do
        expect(collection).to be_a GreenButtonData::ModelCollection
      end

      it "should be a collection of GreenButtonData::UsagePoint instances" do
        expect(collection.first).to be_a GreenButtonData::UsagePoint
      end

      it "should populate attributes" do
        expect(collection.first.id).to eq "1"
        expect(collection.first.meter_reading_url).to eq "https://services.greenbuttondata.org//DataCustodian/espi/1_1/resource/Subscription/5/UsagePoint/1/MeterReading"
        expect(collection.first.service_category).to eq :electricity
        p collection.first
      end
    end
  end
end
