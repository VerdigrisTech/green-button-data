require "spec_helper"

describe GreenButtonData::IntervalBlock do
  let(:all_url) {
    GreenButtonData.configuration.bulk_url(
      subscription_id: 'RDNHDGSNQDNUDA',
      bulk_file_id: 'RDNHDGSNQDNUDA_REVQ_20160801_023157_1.XML'
    )
  }
  let(:token) { "53520584-d640-4812-a721-8a1afa459ff7" }

  subject { GreenButtonData::IntervalBlock }

  let(:client) {
    GreenButtonData.connect do |client|
      client.configuration.base_url = "https://energydatashare.sce.com/DataCustodian/espi/1_1/resource/Batch/"
      client.configuration.bulk_path = "Bulk"
      client.token = token
    end
  }

  let(:interval_blocks) {
    client.interval_block_bulk(
      subscription_id: 'RDNHDGSNQDNUDA',
      bulk_file_id: 'RDNHDGSNQDNUDA_REVQ_20160801_023157_1.XML'
    )
  }

  before do
    GreenButtonData.configure do |config|
      config.base_url = "https://energydatashare.sce.com/DataCustodian/espi/1_1/resource/Batch/"
      config.bulk_path = "Bulk"
    end

    stub_request(:get, all_url).to_return status: 200, body: sce_interval_block
  end


  describe ".all" do
    context "valid authorization" do
      it "should return a ModelCollection" do
        expect(interval_blocks).to be_a GreenButtonData::ModelCollection
      end

      it "should be a collection of GreenButtonData::IntervalBlock instances" do
        expect(interval_blocks.first).to be_a GreenButtonData::IntervalBlock
      end

      let(:interval_block) { interval_blocks.first }

      it "should parse interval_block" do
        expect(interval_block.usage_point_id).to eq 'NB6WRU'
        expect(interval_block.duration).to eq 86400
        expect(interval_block.starts_at).to eq DateTime.new(2015, 8, 13, 7).to_time
        expect(interval_block.ends_at).to eq DateTime.new(2015, 8, 14, 7).to_time
      end

      it "should parse interval_reading" do
        expect(interval_block.to_a.first).to be
        {
          :starts_at => '2015-08-13 00:00:00.000000000 -0700',
          :ends_at=>'2015-08-13 00:15:00.000000000 -0700',
          :duration=>900,
          :value=>270,
          :cost=>0.0
        }
      end
    end
  end
end
