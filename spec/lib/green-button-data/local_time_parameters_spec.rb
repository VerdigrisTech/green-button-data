require "spec_helper"

describe GreenButtonData::LocalTimeParameters do
  let(:all_url) { GreenButtonData.configuration.local_time_parameters_url }
  let(:find_url) { "#{all_url}1" }
  let(:token) { "c51a5047-327d-4a97-9daa-1d1296d11088" }

  subject { GreenButtonData::LocalTimeParameters }

  let(:local_time_parameters) { subject.find(1, token: token) }

  let(:dst_starts_at) { Time.new 2015, 3, 7, 18, 0, 0, '-08:00' }
  let(:dst_ends_at) { Time.new 2015, 10, 31, 19, 0, 0, '-07:00' }
  let(:dst_offset) { 3600 }
  let(:tz_offset) { -18000 }
  let(:total_offset) { dst_offset + tz_offset }

  before do
    GreenButtonData.configure do |config|
      config.base_url = "https://services.greenbuttondata.org/DataCustodian" +
                        "espi/1_1/resource"

      config.local_time_parameters_path = "LocalTimeParameters/"
    end

    stub_request(
      :get, all_url
    ).to_return status: 200, body: espi_local_time_parameters

    stub_request(
      :get, find_url
    ).to_return status: 200, body: espi_local_time_parameters

    stub_request(
      :get, "#{find_url}/"
    ).to_return status: 200, body: espi_local_time_parameters
  end

  describe "Constructor" do
    it "should be a valid instance of LocalTimeParameters" do
      local_time_parameters = subject.new id: "1"
      expect(local_time_parameters).to be_a subject
      expect(local_time_parameters.id).to eq "1"
    end
  end

  describe ".all" do
    context "valid authorization" do
      let(:collection) { subject.all token: token }

      it "should return a ModelCollection" do
        expect(collection).to be_a GreenButtonData::ModelCollection
      end

      it "should be a collection of GreenButtonData::LocalTimeParameters " +
        "instances" do

        expect(collection.first).to be_a subject
      end

      it "should populate attributes" do
        instance = collection.first
        expect(instance.id).to eq "1"
        expect(instance.dst_starts_at 2015).to eq dst_starts_at
        expect(instance.dst_ends_at 2015).to eq dst_ends_at
        expect(instance.dst_offset).to eq dst_offset
        expect(instance.tz_offset).to eq tz_offset
      end
    end
  end

  describe ".find" do
    context "valid authorization" do
      it "is an instance of LocalTimeParameters" do
        expect(local_time_parameters).to be_a subject
        expect(WebMock).to have_requested(:get, "#{find_url}/")
      end

      it "should populate attributes" do
        expect(local_time_parameters.id).to eq "1"
        expect(local_time_parameters.dst_starts_at 2015).to eq dst_starts_at
        expect(local_time_parameters.dst_ends_at 2015).to eq dst_ends_at
        expect(local_time_parameters.dst_offset).to eq dst_offset
        expect(local_time_parameters.tz_offset).to eq tz_offset
      end
    end
  end

  describe "#to_h" do
    it "should return a Hash" do
      expect(local_time_parameters.to_h).to be_a Hash
    end

    it "should populate attributes to Hash key values" do
      expect(local_time_parameters.to_h 2015).to eq({
        dst: {
          starts_at: dst_starts_at,
          ends_at: dst_ends_at,
          offset: dst_offset
        },
        tz_offset: tz_offset,
        total_offset: total_offset
      })
    end
  end
end
