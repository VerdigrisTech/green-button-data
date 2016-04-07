require "spec_helper"

describe GreenButtonData::UsagePoint do
  let(:all_url) { GreenButtonData.configuration.retail_customer_url subscription_id: 5 }
  let(:token) { "53520584-d640-4812-a721-8a1afa459ff7" }

  subject { GreenButtonData::RetailCustomer }

  let(:retail_customers) { subject.all(subscription_id: 5, token: token) }

  before do
    GreenButtonData.configure do |config|
      config.base_url = "https://services.greenbuttondata.org/DataCustodian/" +
        "espi/1_1/resource"
      config.subscription_path = "Subscription/"
      config.retail_customer_path = "Batch/RetailCustomer"
    end

    stub_request(:get, all_url).to_return status: 200, body: pge_retail_customer
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
        expect(retail_customers.first.has_address?).to be_truthy
        expect(retail_customers.first.has_agreement_id_map?).to be_falsey
        expect(retail_customers.first.address_general).to eq '140 HAN RD,KING CITY,CA,95101'
        expect(retail_customers.first.agreement_id_service_uuid_map[:customer_agreement_id]).to be_nil

        expect(retail_customers.last.has_address?).to be_falsey
        expect(retail_customers.last.has_agreement_id_map?).to be_truthy
        expect(retail_customers.last.address_general).to eq ''
        expect(retail_customers.last.agreement_id_service_uuid_map[:customer_agreement_id]).to eq '1112392222'
        expect(retail_customers.last.agreement_id_service_uuid_map[:service_uuid]).to eq '9760620582'
      end
    end
  end
end
