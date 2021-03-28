require 'spec_helper'

describe GreenButtonData::RetailCustomer do
  subject { GreenButtonData::RetailCustomer }

  let(:all_url) { GreenButtonData.configuration.retail_customer_url subscription_id: 5 }
  let(:token) { '53520584-d640-4812-a721-8a1afa459ff7' }
  let(:retail_customers) { subject.all(subscription_id: 5, token: token) }
  let(:customer) { retail_customers.to_a[0] }
  let(:service_location) { retail_customers.to_a[1] }
  let(:customer_account) { retail_customers.to_a[2] }
  let(:customer_agreement) { retail_customers.to_a[3] }
  let(:meter) { retail_customers.to_a[4] }

  before do
    GreenButtonData.configure do |config|
      config.base_url = [
        'https://services.greenbuttondata.org/DataCustodian/',
        'espi/1_1/resource'
      ].join('')

      config.subscription_path = 'Subscription/'
      config.retail_customer_path = 'Batch/RetailCustomer'
    end

    stub_request(:get, all_url).to_return status: 200, body: pge_retail_customer
  end

  describe 'Constructor' do
    it 'returns a valid instance of RetailCustomer' do
      retail_customer = subject.new id: '1'
      expect(retail_customer).to be_a GreenButtonData::RetailCustomer
      expect(retail_customer.id).to eq '1'
    end
  end

  describe '.all' do
    context 'valid authorization' do
      it 'returns a ModelCollection' do
        expect(retail_customers).to be_a GreenButtonData::ModelCollection
      end

      it 'returns a collection of GreenButtonData::RetailCustomer instances' do
        retail_customers.each do |retail_customer|
          expect(retail_customer).to be_a GreenButtonData::RetailCustomer
        end
      end

      it 'sets Customer attributes' do
        expect(customer.name).to eq('ACME INDUSTRIES')
        expect(customer.links).to eq(
          related: ['https://api.pge.com/GreenButtonConnect/espi/1_1/resource/RetailCustomer/92772/Customer/MjYyNjk0MDkxMA==/CustomerAccount'],
          self: 'https://api.pge.com/GreenButtonConnect/espi/1_1/resource/RetailCustomer/92772/Customer/MjYyNjk0MDkxMA==',
          up: 'https://api.pge.com/GreenButtonConnect/espi/1_1/resource/RetailCustomer/92772/Customer'
        )
      end

      it 'sets ServiceLocation attributes' do
        expect(service_location.links).to eq(
          related: ['https://api.pge.com/GreenButtonConnect/espi/1_1/resource/RetailCustomer/92772/Customer/MjYyNjk0MDkxMA==/CustomerAccount/4872715821/CustomerAgreement/9760620582/ServiceLocation/ODg5NDU5MDcwNQ==/EndDevice'],
          self: 'https://api.pge.com/GreenButtonConnect/espi/1_1/resource/RetailCustomer/92772/Customer/MjYyNjk0MDkxMA==/CustomerAccount/4872715821/CustomerAgreement/9760620582/ServiceLocation/ODg5NDU5MDcwNQ==',
          up: 'https://api.pge.com/GreenButtonConnect/espi/1_1/resource/RetailCustomer/92772/Customer/MjYyNjk0MDkxMA==/CustomerAccount/4872715821/CustomerAgreement/9760620582/ServiceLocation'
        )
      end

      it 'sets CustomerAccount attributes' do
        expect(customer_account.account_id).to eq('1687340014')
        expect(customer_account.links).to eq(
          related: ['https://api.pge.com/GreenButtonConnect/espi/1_1/resource/RetailCustomer/92772/Customer/MjYyNjk0MDkxMA==/CustomerAccount/4872715821/CustomerAgreement'],
          self: 'https://api.pge.com/GreenButtonConnect/espi/1_1/resource/RetailCustomer/92772/Customer/MjYyNjk0MDkxMA==/CustomerAccount/4872715821',
          up: 'https://api.pge.com/GreenButtonConnect/espi/1_1/resource/RetailCustomer/92772/Customer/MjYyNjk0MDkxMA==/CustomerAccount'
        )
      end

      it 'sets CustomerAgreement attributes' do
        expect(customer_agreement.links).to eq(
          related: [],
          self: 'https://api.pge.com/GreenButtonConnect/espi/1_1/resource/RetailCustomer/92772/Customer/MjYyNjk0MDkxMA==/CustomerAccount/4872715821/CustomerAgreement/9760620582',
          up: 'https://api.pge.com/GreenButtonConnect/espi/1_1/resource/RetailCustomer/92772/Customer/MjYyNjk0MDkxMA==/CustomerAccount/4872715821/CustomerAgreement'
        )
      end

      it 'sets Meter attributes' do
        expect(meter.meter_serial_number).to eq('1121183459')
        expect(meter.meter_interval_length).to eq(900)
        expect(meter.meter_type).to eq('EMTR 12S/XP/CL200/3W/5Dials')
        expect(meter.links).to eq(
          related: [],
          self: 'https://api.pge.com/GreenButtonConnect/espi/1_1/resource/RetailCustomer/92772/Customer/MjYyNjk0MDkxMA==/CustomerAccount/4872715821/CustomerAgreement/9760620582/ServiceLocation/ODg5NDU5MDcwNQ==/Meter/1121183459',
          up: 'https://api.pge.com/GreenButtonConnect/espi/1_1/resource/RetailCustomer/92772/Customer/MjYyNjk0MDkxMA==/CustomerAccount/4872715821/CustomerAgreement/9760620582/ServiceLocation/ODg5NDU5MDcwNQ==/Meter'
        )
      end
    end
  end

  describe '#has_address?' do
    context 'when ServiceLocation' do
      it 'returns true' do
        expect(service_location.has_address?).to be_truthy
      end
    end

    context 'when not ServiceLocation' do
      it 'returns false' do
        expect(customer.has_address?).to be_falsey
        expect(customer_account.has_address?).to be_falsey
        expect(customer_agreement.has_address?).to be_falsey
        expect(meter.has_address?).to be_falsey
      end
    end
  end

  describe '#address_general' do
    context 'when ServiceLocation' do
      it 'returns address' do
        expect(service_location.address_general).to eq '140 HAN RD,KING CITY,CA,95101'
      end
    end

    context 'when not ServiceLocation' do
      it 'returns empty string' do
        expect(customer.address_general).to eq('')
        expect(customer_agreement.address_general).to eq('')
        expect(customer_account.address_general).to eq('')
        expect(meter.address_general).to eq('')
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
        expect(customer.has_agreement_id_map?).to be_falsey
        expect(service_location.has_agreement_id_map?).to be_falsey
        expect(customer_account.has_agreement_id_map?).to be_falsey
        expect(meter.has_agreement_id_map?).to be_falsey
      end
    end
  end

  describe '#agreement_id_service_uuid_map' do
    context 'when CustomerAgreement' do
      it 'returns hash with values' do
        expect(customer_agreement.agreement_id_service_uuid_map[:customer_agreement_id]).to eq '1112392222'
        expect(customer_agreement.agreement_id_service_uuid_map[:service_uuid]).to eq '9760620582'
      end
    end

    context 'when not CustomerAgreement' do
      it 'returns empty hash' do
        expect(customer.agreement_id_service_uuid_map).to eq({})
        expect(service_location.agreement_id_service_uuid_map).to eq({})
        expect(customer_account.agreement_id_service_uuid_map).to eq({})
        expect(meter.agreement_id_service_uuid_map).to eq({})
      end
    end
  end
end
