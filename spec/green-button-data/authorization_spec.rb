require "spec_helper"

describe GreenButtonData::Authorization do
  let(:url) { "https://services.greenbuttondata.org/DataCustodian/espi/1_1/resource/Authorization" }
  let(:token) { "53520584-d640-4812-a721-8a1afa459ff7" }

  subject { GreenButtonData::Authorization }

  before do
    stub_request(:get, url).to_return status: 200, body: espi_authorization
  end

  describe "#all" do
    context "valid authorization" do
      it "should return a ModelCollection" do
        expect(subject.all(url, token: token)).to be_a GreenButtonData::ModelCollection
      end

      it "should be a collection of GreenButtonData::Authorization instances" do
        expect(subject.all(url, token: token).first).to be_a GreenButtonData::Authorization
      end
    end
  end

  describe "#first" do
    context "valid authorization" do
      it "should return the first Authorization entry" do
        expect(subject.first(url, token: token)).to be_a GreenButtonData::Authorization
      end
    end
  end

  describe "#last" do
    context "valid authorization" do
      it "should return the last Authorization entry" do
        expect(subject.last(url, token: token)).to be_a GreenButtonData::Authorization
      end
    end
  end
end
