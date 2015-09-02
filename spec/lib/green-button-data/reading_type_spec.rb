require "spec_helper"

describe GreenButtonData::ReadingType do
  let(:all_url) { GreenButtonData.configuration.reading_type_url }
  let(:find_url) { "#{all_url}11" }
  let(:token) { "c51a5047-327d-4a97-9daa-1d1296d11088" }

  subject { GreenButtonData::ReadingType }

  let(:reading_type) { subject.find(11, token: token) }

  let(:accumulation_behaviour) { :delta_data }
  let(:commodity) { :electricity_secondary_metered }
  let(:currency) { :usd }
  let(:data_qualifier) { :normal }
  let(:flow_direction) { :forward }
  let(:interval_length) { 300 }
  let(:kind) { :energy }
  let(:phase) { :s12_n }
  let(:time_attribute) { :none }
  let(:scale_factor) { 1.0 }
  let(:unit_of_measurement) { :Wh }

  before do
    GreenButtonData.configure do |config|
      config.base_url = "https://services.greenbuttondata.org/DataCustodian" +
                        "espi/1_1/resource"

      config.reading_type_path = "ReadingType/"
    end

    stub_request(:get, all_url).to_return status: 200, body: espi_reading_types
    stub_request(:get, find_url).to_return status: 200, body: espi_reading_type

    stub_request(
      :get, "#{find_url}/"
    ).to_return status: 200, body: espi_reading_type
  end

  describe "Constructor" do
    it "should be a valid instance of ReadingType" do
      reading_type = subject.new id: "1"
      expect(reading_type).to be_a subject
      expect(reading_type.id).to eq "1"
    end
  end

  describe ".all" do
    context "valid authorization" do
      let(:collection) { subject.all token: token }

      it "should return a ModelCollection" do
        expect(collection).to be_a GreenButtonData::ModelCollection
      end

      it "should be a collection of GreenButtonData::ReadingType instances" do
        expect(collection.first).to be_a subject
      end

      it "should populate attributes" do
        instance = collection.first
        expect(instance.id).to eq "11"
        expect(instance.accumulation_behaviour).to eq accumulation_behaviour
        expect(instance.commodity).to eq commodity
        expect(instance.currency).to eq currency
        expect(instance.data_qualifier).to eq data_qualifier
        expect(instance.flow_direction).to eq flow_direction
        expect(instance.interval_length).to eq interval_length
        expect(instance.kind).to eq kind
        expect(instance.phase).to eq phase
        expect(instance.time_attribute).to eq time_attribute
        expect(instance.scale_factor).to eq scale_factor
        expect(instance.unit_of_measurement).to eq unit_of_measurement
      end
    end
  end

  describe ".find" do
    context "valid authorization" do
      it "is an instance of ReadingType" do
        expect(reading_type).to be_a subject
        expect(WebMock).to have_requested(:get, "#{find_url}/")
      end

      it "should populate attributes" do
        expect(reading_type.id).to eq "11"
        expect(reading_type.accumulation_behaviour).to eq accumulation_behaviour
        expect(reading_type.commodity).to eq commodity
        expect(reading_type.currency).to eq currency
        expect(reading_type.data_qualifier).to eq data_qualifier
        expect(reading_type.flow_direction).to eq flow_direction
        expect(reading_type.interval_length).to eq interval_length
        expect(reading_type.kind).to eq kind
        expect(reading_type.phase).to eq phase
        expect(reading_type.time_attribute).to eq time_attribute
        expect(reading_type.scale_factor).to eq scale_factor
        expect(reading_type.unit_of_measurement).to eq unit_of_measurement
      end
    end
  end

  describe "#to_h" do
    it "should return a Hash" do
      expect(reading_type.to_h).to be_a Hash
    end

    it "should populate attributes to Hash key values" do
      expect(reading_type.to_h).to eq({
        accumulation_behaviour: accumulation_behaviour,
        commodity: commodity,
        consumption_tier: nil,
        cpp: nil,
        currency: currency,
        data_qualifier: data_qualifier,
        default_quality: nil,
        flow_direction: flow_direction,
        kind: kind,
        measuring_period: nil,
        phase: phase,
        scale_factor: scale_factor,
        time_attribute: time_attribute,
        tou: nil,
        unit_of_measurement: unit_of_measurement
      })
    end
  end
end
