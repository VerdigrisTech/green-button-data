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

  let(:customer_account) { retail_customers.to_a[0] }
  let(:customer_agreement) { retail_customers.to_a[1] }
  let(:service_location) { retail_customers.to_a[2] }
  let(:meter) { retail_customers.to_a[3] }

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
        retail_customers.each do |retail_customer|
          expect(retail_customer).to be_a GreenButtonData::RetailCustomer
        end
      end

      it 'sets Meter attributes' do
        expect(meter.meter_serial_number).to eq('2.16.840.1.114416.1.5.222013991111')
        expect(meter.meter_type).to eq('C2SOD')
        expect(meter.links).to eq(
          related: ['https://services.greenbuttondata.org/DataCustodian/espi/1_1/resource/RetailCustomer/VJEWP31BE/Customer/1/CustomerAccount/1111111/CustomerAgreement/NB6WRU/Meter/14106263/EndDevice'],
          self: 'https://services.greenbuttondata.org/DataCustodian/espi/1_1/resource/RetailCustomer/VJEWP31BE/Customer/1/CustomerAccount/1111111/CustomerAgreement/NB6WRU/Meter/14106263',
          up: 'https://services.greenbuttondata.org/DataCustodian/espi/1_1/resource/RetailCustomer/VJEWP31BE/Customer/1/CustomerAccount/1111111/CustomerAgreement/NB6WRU/Meter'
        )
      end
    end
  end

  describe '#has_agreement_id_map?' do
    context 'when CustomerAgreement' do
      it 'returns true' do
        expect(customer_agreement.has_agreement_id_map?).to be_truthy
      end
    end

    context 'when not CustomerAgreement' do
      it 'returns false' do
        expect(service_location.has_agreement_id_map?).to be_falsey
        expect(customer_account.has_agreement_id_map?).to be_falsey
        expect(meter.has_agreement_id_map?).to be_falsey
      end
    end
  end

  describe '#agreement_id_service_uuid_map' do
    context 'when CustomerAgreement' do
      it 'returns hash with values' do
        expect(customer_agreement.agreement_id_service_uuid_map[:customer_agreement_id]).to eq '3-001-4647-18'
        expect(customer_agreement.agreement_id_service_uuid_map[:service_uuid]).to eq 'NB6WRU'
      end
    end

    context 'when not CustomerAgreement' do
      it 'returns empty hash' do
        expect(service_location.agreement_id_service_uuid_map).to eq({})
        expect(customer_account.agreement_id_service_uuid_map).to eq({})
        expect(meter.agreement_id_service_uuid_map).to eq({})
      end
    end
  end

  describe '#address_general' do
    context 'when ServiceLocation' do
      it 'returns address' do
        expect(service_location.address_general).to eq '11111 COLORADO ST,PALM DESERT,CA,92260'
      end
    end

    context 'when not ServiceLocation' do
      it 'returns empty string' do
        expect(customer_agreement.address_general).to eq('')
        expect(customer_account.address_general).to eq('')
        expect(meter.address_general).to eq('')
      end
    end
  end
end
