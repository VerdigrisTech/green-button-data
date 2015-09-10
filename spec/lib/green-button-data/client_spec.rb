require "spec_helper"

describe GreenButtonData::Client do
  let :config do
    {
      base_url: "https://services.greenbuttondata.org/DataCustodian/espi/1_1/" +
                "resource/",
      application_information_path: "ApplicationInformation/",
      authorization_path: "Authorization/",
      interval_block_path: "IntervalBlock/",
      local_time_parameters_path: "LocalTimeParameters/",
      meter_reading_path: "MeterReading/",
      reading_type_path: "ReadingType/",
      subscription_path: "Subscription/",
      usage_point_path: "UsagePoint/",
      usage_summary_path: "UsageSummary/"
    }
  end

  let(:token) { "foo" }
  let(:model_collection_klass) { GreenButtonData::ModelCollection }

  subject(:client) { GreenButtonData::Client.new config }

  describe "Constructor" do
    it { is_expected.to be_a GreenButtonData::Client }

    it "should instantiate with configuration options" do
      expect(client.configuration.base_url).to eq config[:base_url]

      expect(
        client.configuration.application_information_path
      ).to eq config[:application_information_path]

      expect(
        client.configuration.authorization_path
      ).to eq config[:authorization_path]

      expect(
        client.configuration.interval_block_path
      ).to eq config[:interval_block_path]

      expect(
        client.configuration.local_time_parameters_path
      ).to eq config[:local_time_parameters_path]

      expect(
        client.configuration.meter_reading_path
      ).to eq config[:meter_reading_path]

      expect(
        client.configuration.reading_type_path
      ).to eq config[:reading_type_path]

      expect(
        client.configuration.subscription_path
      ).to eq config[:subscription_path]

      expect(
        client.configuration.usage_point_path
      ).to eq config[:usage_point_path]

      expect(
        client.configuration.usage_summary_path
      ).to eq config[:usage_summary_path]
    end
  end

  describe "#application_information" do
    let(:id) { 2 }
    let(:klazz) { GreenButtonData::ApplicationInformation }
    let(:application_information) {
      client.application_information id, token: token
    }
    let(:application_informations) {
      client.application_information token: token
    }

    context "id is specified" do
      before do
        stub_request(
          :get,
          client.configuration.application_information_url(id)
        ).to_return status: 200, body: espi_application_information
      end

      it "should return an instance of ApplicationInformation" do
        expect(application_information).to be_a klazz
      end
    end

    context "id is not specified" do
      before do
        stub_request(
          :get,
          client.configuration.application_information_url
        ).to_return status: 200, body: espi_application_information
      end

      it "should return a ModelCollection" do
        expect(application_informations).to be_a model_collection_klass
      end
    end
  end

  describe "#authorization" do
    let(:id) { 4 }
    let(:klazz) { GreenButtonData::Authorization }
    let(:authorization) { client.authorization id, token: token }
    let(:authorizations) { client.authorization token: token }

    context "id is specified" do
      before do
        stub_request(
          :get,
          client.configuration.authorization_url(id)
        ).to_return status: 200, body: espi_authorization
      end

      it "should return an instance of Authorization" do
        expect(authorization).to be_a klazz
      end
    end

    context "id is not specified" do
      before do
        stub_request(
          :get,
          client.configuration.authorization_url
        ).to_return status: 200, body: espi_authorization
      end

      it "should return a ModelCollection" do
        expect(authorizations).to be_a model_collection_klass
      end
    end
  end

  describe "#interval_block" do
    let(:id) { 1 }
    let(:meter_reading_id) { 1 }
    let(:usage_point_id) { 1 }
    let(:subscription_id) { 5 }
    let(:klazz) { GreenButtonData::IntervalBlock }
    let(:interval_block) { client.interval_block id, token: token }
    let(:interval_blocks) { client.interval_block token: token }
    let(:subscription_interval_block) {
      client.interval_block(
        id,
        meter_reading_id: meter_reading_id,
        usage_point_id: usage_point_id,
        subscription_id: subscription_id,
        token: token
      )
    }
    let(:subscription_interval_blocks) {
      client.interval_block(
        meter_reading_id: meter_reading_id,
        usage_point_id: usage_point_id,
        subscription_id: subscription_id,
        token: token
      )
    }

    before do
      stub_request(
        :get,
        client.configuration.interval_block_url(interval_block_id: id)
      ).to_return status: 200, body: espi_interval_block

      stub_request(
        :get,
        client.configuration.interval_block_url
      ).to_return status: 200, body: espi_interval_block

      stub_request(
        :get,
        client.configuration.interval_block_url(
          interval_block_id: id,
          meter_reading_id: meter_reading_id,
          usage_point_id: usage_point_id,
          subscription_id: subscription_id
        )
      ).to_return status: 200, body: espi_interval_block

      stub_request(
        :get,
        client.configuration.interval_block_url(
          meter_reading_id: meter_reading_id,
          usage_point_id: usage_point_id,
          subscription_id: subscription_id
        )
      ).to_return status: 200, body: espi_interval_block
    end

    context "id is specified" do
      it "should return an instance of IntervalBlock" do
        expect(interval_block).to be_a klazz
      end

      context "with subscription_id, usage_point_id, meter_reading_id" do
        it "should return an instance of IntervalBlock" do
          expect(subscription_interval_block).to be_a klazz
        end
      end
    end

    context "id is specified as a keyword argument" do
      it "should return an instance of IntervalBlock" do
        expect(
          client.interval_block(
            interval_block_id: id,
            token: token
          )
        ).to be_a klazz
      end

      context "with subscription_id, usage_point_id, meter_reading_id" do
        it "should return an instance of IntervalBlock" do
          expect(
            client.interval_block(
              interval_block_id: id,
              meter_reading_id: meter_reading_id,
              usage_point_id: usage_point_id,
              subscription_id: subscription_id,
              token: token
            )
          ).to be_a klazz
        end
      end
    end

    context "id is not specified" do
      it "should return a ModelCollection" do
        expect(interval_blocks).to be_a model_collection_klass
      end

      context "with subscription_id, usage_point_id, meter_reading_id" do
        it "should return a ModelCollection" do
          expect(subscription_interval_blocks).to be_a model_collection_klass
        end
      end
    end
  end

  describe "#local_time_parameters" do
    let(:id) { 1 }
    let(:klazz) { GreenButtonData::LocalTimeParameters }
    let(:local_time_parameters) {
      client.local_time_parameters id,
      token: token
    }
    let(:all_local_time_parameters) {
      client.local_time_parameters token: token
    }

    context "id is specified" do
      before do
        stub_request(
          :get,
          client.configuration.local_time_parameters_url(id)
        ).to_return status: 200, body: espi_local_time_parameters
      end

      it "should return an instance of LocalTimeParameters" do
        expect(local_time_parameters).to be_a klazz
      end
    end

    context "id is not specified" do
      before do
        stub_request(
          :get,
          client.configuration.local_time_parameters_url
        ).to_return status: 200, body: espi_local_time_parameters
      end

      it "should return a ModelCollection" do
        expect(all_local_time_parameters).to be_a model_collection_klass
      end
    end
  end

  describe "#meter_reading" do
    let(:id) { 1 }
    let(:usage_point_id) { 2 }
    let(:subscription_id) { 5 }
    let(:klazz) { GreenButtonData::MeterReading }
    let(:meter_reading) { client.meter_reading id, token: token }
    let(:meter_readings) { client.meter_reading token: token }
    let(:subscription_meter_reading) {
      client.meter_reading(
        id,
        usage_point_id: usage_point_id,
        subscription_id: subscription_id,
        token: token
      )
    }
    let(:subscription_meter_readings) {
      client.meter_reading(
        usage_point_id: usage_point_id,
        subscription_id: subscription_id,
        token: token
      )
    }

    before do
      stub_request(
        :get,
        client.configuration.meter_reading_url(meter_reading_id: id)
      ).to_return status: 200, body: espi_usage_point_meter_reading

      stub_request(
        :get,
        client.configuration.meter_reading_url
      ).to_return status: 200, body: espi_usage_point_meter_readings

      stub_request(
        :get,
        client.configuration.meter_reading_url(
          meter_reading_id: id,
          usage_point_id: usage_point_id,
          subscription_id: subscription_id
        )
      ).to_return status: 200, body: espi_usage_point_meter_reading

      stub_request(
        :get,
        client.configuration.meter_reading_url(
          usage_point_id: usage_point_id,
          subscription_id: subscription_id
        )
      ).to_return status: 200, body: espi_usage_point_meter_readings
    end

    context "id is specified" do
      it "should return an instance of MeterReading" do
        expect(meter_reading).to be_a klazz
      end

      context "with subscription_id and usage_point_id" do
        it "should return an instance of MeterReading" do
          expect(subscription_meter_reading).to be_a klazz
        end
      end
    end

    context "id is specified as a keyword argument" do
      it "should return an instance of MeterReading" do
        expect(client.meter_reading meter_reading_id: id).to be_a klazz
      end

      context "with subscription_id and usage_point_id" do
        it "should return an instance of MeterReading" do
          expect(
            client.meter_reading(
              meter_reading_id: id,
              usage_point_id: usage_point_id,
              subscription_id: subscription_id
            )
          ).to be_a klazz
        end
      end
    end

    context "id is not specified" do
      it "should return a ModelCollection" do
        expect(meter_readings).to be_a model_collection_klass
      end

      context "with subscription_id and usage_point_id" do
        it "should return a ModelCollection" do
          expect(subscription_meter_readings).to be_a model_collection_klass
        end
      end
    end
  end

  describe "#reading_type" do
    let(:id) { 11 }
    let(:klazz) { GreenButtonData::ReadingType }
    let(:reading_type) { client.reading_type id, token: token }
    let(:reading_types) { client.reading_type token: token }

    context "id is specified" do
      before do
        stub_request(
          :get,
          client.configuration.reading_type_url(id)
        ).to_return status: 200, body: espi_reading_type
      end

      it "should return an instance of ReadingType" do
        expect(reading_type).to be_a klazz
      end
    end

    context "id is not specified" do
      before do
        stub_request(
          :get,
          client.configuration.reading_type_url
        ).to_return status: 200, body: espi_reading_types
      end

      it "should return a ModelCollection" do
        expect(reading_types).to be_a model_collection_klass
      end
    end
  end

  describe "#ssl=" do
    context "value is a valid Hash of options" do
      require 'openssl'

      let(:cert) { OpenSSL::X509::Certificate.new }
      let(:pkey) { OpenSSL::PKey::RSA.new }

      before do
        client.ssl = {
          client_cert: cert,
          client_secret: pkey
        }
      end

      it {
        is_expected.to have_attributes ssl: {
          client_cert: cert,
          client_secret: pkey
        }
      }
    end

    context "invalid value type" do
      it "raises ArgumentError" do
        expect { client.ssl = "paradox" }.to raise_error ArgumentError
      end
    end
  end

  describe "#token=" do
    context "value type is String" do
      before { client.token = "foo" }
      it { is_expected.to have_attributes token: "foo" }
    end

    context "invalid value type" do
      it "raises ArgumentError" do
        expect { client.token = 0 }.to raise_error ArgumentError
      end
    end
  end

  describe "#usage_point" do
    let(:id) { 2 }
    let(:subscription_id) { 1 }
    let(:klazz) { GreenButtonData::UsagePoint }
    let(:usage_point) { client.usage_point id, token: token }
    let(:usage_points) { client.usage_point token: token }
    let(:subscription_usage_point) {
      client.usage_point id, subscription_id: subscription_id, token: token
    }
    let(:subscription_usage_points) {
      client.usage_point subscription_id: subscription_id, token: token
    }

    before do
      stub_request(
        :get,
        client.configuration.usage_point_url(usage_point_id: id)
      ).to_return status: 200, body: espi_usage_point

      stub_request(
        :get,
        client.configuration.usage_point_url
      ).to_return status: 200, body: espi_usage_points

      stub_request(
        :get,
        client.configuration.usage_point_url(
          usage_point_id: id, subscription_id: subscription_id
        )
      ).to_return status: 200, body: espi_usage_point

      stub_request(
        :get,
        client.configuration.usage_point_url(
          subscription_id: subscription_id
        )
      ).to_return status: 200, body: espi_usage_points
    end

    context "id is specified as single value" do
      it "should return an instance of UsagePoint" do
        expect(usage_point).to be_a klazz
      end

      context "with subscription_id" do
        it "should return an instance of UsagePoint" do
          expect(subscription_usage_point).to be_a klazz
        end
      end
    end

    context "id is specified as a keyword argument" do
      it "should return an instance of UsagePoint" do
        expect(
          client.usage_point usage_point_id: id, token: token
        ).to be_a klazz
      end

      context "with subscription_id" do
        it "should return an instance of UsagePoint" do
          expect(
            client.usage_point(
              usage_point_id: id,
              subscription_id: subscription_id,
              token: token
            )
          ).to be_a klazz
        end
      end
    end

    context "id is not specified" do
      it "should return a ModelCollection" do
        expect(usage_points).to be_a model_collection_klass
      end

      context "with subscription_id" do
        it "should return a ModelCollection" do
          expect(subscription_usage_points).to be_a model_collection_klass
        end
      end
    end
  end

  describe "#usage_summary" do
    let(:id) { 1 }
    let(:usage_point_id) { 1 }
    let(:subscription_id) { 5 }
    let(:klazz) { GreenButtonData::UsageSummary }
    let(:usage_summary) {
      client.usage_summary(
        id,
        usage_point_id: usage_point_id,
        subscription_id: subscription_id,
        token: token
      )
    }

    let(:usage_summaries) {
      client.usage_summary(
        usage_point_id: usage_point_id,
        subscription_id: subscription_id,
        token: token
      )
    }

    before do
      stub_request(
        :get,
        client.configuration.usage_summary_url(
          usage_summary_id: id,
          usage_point_id: usage_point_id,
          subscription_id: subscription_id
        )
      ).to_return status: 200, body: espi_usage_summary

      stub_request(
        :get,
        client.configuration.usage_summary_url(
          usage_point_id: usage_point_id,
          subscription_id: subscription_id
        )
      ).to_return status: 200, body: espi_usage_summaries
    end

    context "id is specified as single value" do
      it "should return an instance of UsageSummary" do
        expect(usage_summary).to be_a klazz
      end
    end

    context "id is specified as a keyword argument" do
      it "should return an instance of UsagePoint" do
        expect(
          client.usage_summary(
            usage_summary_id: id,
            usage_point_id: usage_point_id,
            subscription_id: subscription_id,
            token: token
          )
        ).to be_a klazz
      end
    end

    context "id is not specified" do
      it "should return a ModelCollection" do
        expect(usage_summaries).to be_a model_collection_klass
      end
    end
  end
end
