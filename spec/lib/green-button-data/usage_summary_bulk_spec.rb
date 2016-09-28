require "spec_helper"

describe GreenButtonData::UsageSummary do
  let(:all_url) {
    GreenButtonData.configuration.bulk_url(
      subscription_id: 'RDNHDGSNQDNUDA',
      bulk_file_id: 'RDNHDGSNQDNUDA_REVQ_20160801_023157_1.XML'
    )
  }
  let(:token) { "53520584-d640-4812-a721-8a1afa459ff7" }

  subject { GreenButtonData::UsageSummary }

  let(:client) {
    GreenButtonData.connect do |client|
      client.configuration.base_url = "https://energydatashare.sce.com/DataCustodian/espi/1_1/resource/Batch/"
      client.configuration.bulk_path = "Bulk"
      client.token = token
    end
  }

  let(:usage_summaries) {
    client.usage_summary_bulk(
      subscription_id: 'RDNHDGSNQDNUDA',
      bulk_file_id: 'RDNHDGSNQDNUDA_REVQ_20160801_023157_1.XML'
    )
  }

  before do
    GreenButtonData.configure do |config|
      config.base_url = "https://energydatashare.sce.com/DataCustodian/espi/1_1/resource/Batch/"
      config.bulk_path = "Bulk"
    end

    stub_request(:get, all_url).to_return status: 200, body: sce_usage_summary_and_interval_block
  end


  describe ".all" do
    context "valid authorization" do
      it "should return a ModelCollection" do
        expect(usage_summaries).to be_a GreenButtonData::ModelCollection
      end

      it "should be a collection of GreenButtonData::UsageSummary instances" do
        expect(usage_summaries.first).to be_a GreenButtonData::UsageSummary
      end

      let(:bill) { usage_summaries.first }
      let(:bill_detail) { usage_summaries.last }

      it "should parse bill" do
        expect(bill.billing_period).to be_a GreenButtonData::Parser::Interval
        expect(bill.usage_point_id).to eq 'NB6WRU'
        expect(bill.overall_consumption_last_period).
          to be_a GreenButtonData::Parser::SummaryMeasurement
        expect(bill.overall_consumption_last_period.uom).
          to be :Wh
        expect(bill.overall_consumption_last_period.value).
          to be 1152000.0
        expect(bill.cost).to be 174.18
      end

      it "should parse bill_detail" do
        expect(bill_detail.billing_period).to be_a GreenButtonData::Parser::Interval
        expect(bill_detail.usage_point_id).to eq 'NB6WRU'
        expect(bill_detail.cost_additional_detail_last_periods).
          to be_a Array
        expect(bill_detail.cost_additional_detail_last_periods.first.uom).
          to be :Wh
        expect(bill_detail.cost_additional_detail_last_periods.first.value).
          to be 0.0
        expect(bill_detail.cost_additional_detail_last_periods.first.amount).to be 4042000
        expect(bill_detail.cost_additional_detail_last_periods.first.note).
          to eq "Energy Generation Fee"
        expect(bill_detail.cost_additional_detail_last_periods.first.item_kind).
          to be 1
      end
    end
  end
end
