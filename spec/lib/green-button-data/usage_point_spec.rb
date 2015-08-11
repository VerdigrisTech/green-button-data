require "spec_helper"

describe GreenButtonData::UsagePoint do
  let(:all_url) { GreenButtonData.configuration.usage_point_url }
  let :find_url do
    "https://services.greenbuttondata.org/DataCustodian/espi/1_1/resource/UsagePoint/2"
  end
  let(:token) { "53520584-d640-4812-a721-8a1afa459ff7" }

  subject { GreenButtonData::UsagePoint }

  let(:usage_point) { subject.find(2, token: token) }

  before do
    GreenButtonData.configure do |config|
      config.base_url = "https://services.greenbuttondata.org/"
      config.usage_point_path = "DataCustodian/espi/1_1/resource/UsagePoint"
    end

    stub_request(:get, all_url).to_return status: 200, body: espi_usage_points
    stub_request(:get, find_url).to_return status: 200, body: espi_usage_point
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
        expect(collection.first.local_time_parameters_url).to eq "https://services.greenbuttondata.org//DataCustodian/espi/1_1/resource/LocalTimeParameters/1"
        expect(collection.first.meter_reading_url).to eq "https://services.greenbuttondata.org//DataCustodian/espi/1_1/resource/Subscription/1/UsagePoint/1/MeterReading"
        expect(collection.first.electric_power_usage_summary_url).to eq "https://services.greenbuttondata.org//DataCustodian/espi/1_1/resource/Subscription/1/UsagePoint/1/ElectricPowerUsageSummary"
        expect(collection.first.service_category).to eq :electricity
      end
    end
  end

  describe "#find" do
    context "valid authorization" do
      it "is an instance of UsagePoint" do
        expect(usage_point).to be_a GreenButtonData::UsagePoint
        expect(WebMock).to have_requested(:get, find_url)
      end

      it "should populate attributes" do
        expect(usage_point.id).to eq "2"
        expect(usage_point.local_time_parameters_url).to eq "https://services.greenbuttondata.org//DataCustodian/espi/1_1/resource/LocalTimeParameters/1"
        expect(usage_point.meter_reading_url).to eq "https://services.greenbuttondata.org//DataCustodian/espi/1_1/resource/Subscription/5/UsagePoint/2/MeterReading"
        expect(usage_point.electric_power_usage_summary_url).to eq "https://services.greenbuttondata.org//DataCustodian/espi/1_1/resource/Subscription/5/UsagePoint/2/ElectricPowerUsageSummary"
        expect(usage_point.service_category).to eq :electricity
      end
    end
  end

  describe "relations" do
    let :meter_readings_url do
      "https://services.greenbuttondata.org//DataCustodian/espi/1_1/resource/Subscription/5/UsagePoint/2/MeterReading"
    end

    before do
      stub_request(:get, meter_readings_url).
      to_return status: 200, body: espi_usage_point_meter_readings
    end

    it "should lazy load related resources" do
      expect(usage_point.meter_readings).to be_a GreenButtonData::ModelCollection
      expect(usage_point.meter_readings.size).to eq 1
      expect(usage_point.meter_readings.first).to be_a GreenButtonData::MeterReading
    end
  end
end
