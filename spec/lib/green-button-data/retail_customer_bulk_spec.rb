require "spec_helper"

describe GreenButtonData::RetailCustomer do
  let(:all_url) {
    GreenButtonData.configuration.bulk_url(
      subscription_id: 'RDNHDGSNQDNUDA',
      bulk_file_id: 'RDNHDGSNQDNUDA_RCUST_20160801_023157_1.XML'
    )
  }
  let(:token) { "53520584-d640-4812-a721-8a1afa459ff7" }

  subject { GreenButtonData::RetailCustomer }

  let(:client) {
    GreenButtonData.connect do |client|
      client.configuration.base_url = "https://energydatashare.sce.com/DataCustodian/espi/1_1/resource/Batch/"
      client.configuration.bulk_path = "Bulk"
      client.token = token
    end
  }

  let(:retail_customers) {
    client.retail_customer_bulk(
      subscription_id: 'RDNHDGSNQDNUDA',
      bulk_file_id: 'RDNHDGSNQDNUDA_RCUST_20160801_023157_1.XML'
    )
  }

  before do
    GreenButtonData.configure do |config|
      config.base_url = "https://energydatashare.sce.com/DataCustodian/espi/1_1/resource/Batch/"
      config.bulk_path = "Bulk"
    end

    stub_request(:get, all_url).to_return status: 200, body: sce_retail_customer
  end

  describe "Constructor" do
    it "should be a valid instance of RetailCustomer" do
      retail_customer = subject.new id: "1"
      expect(retail_customer).to be_a GreenButtonData::RetailCustomer
      expect(retail_customer.id).to eq "1"
    end
  end

  describe ".all" do
    context "valid authorization" do
      it "should return a ModelCollection" do
        expect(retail_customers).to be_a GreenButtonData::ModelCollection
      end

      it "should be a collection of GreenButtonData::RetailCustomer instances" do
        expect(retail_customers.first).to be_a GreenButtonData::RetailCustomer
      end

      it "should populate attributes" do
        expect(retail_customers.first.has_agreement_id_map?).to be_truthy
        expect(retail_customers.first.agreement_id_service_uuid_map[:customer_agreement_id]).to eq '3-001-4647-18'
        expect(retail_customers.first.agreement_id_service_uuid_map[:service_uuid]).to eq 'NB6WRU'

        expect(retail_customers.last.has_agreement_id_map?).to be_falsey
      end
    end
  end
end
