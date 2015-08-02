require "spec_helper"

describe GreenButtonData::Parser::Authorization do
  context "espi namespace" do
    let(:feed) { GreenButtonData::Feed }
    let :authorization do
      feed.parse(espi_authorization)
          .entries
          .first
          .content
          .authorization
    end

    subject { authorization }

    it "should parse authorized period" do
      expect(subject.authorized_period.start).to eq 0
      expect(subject.authorized_period.duration).to eq 0
    end

    it "should parse published period" do
      expect(subject.published_period.start).to eq 0
      expect(subject.published_period.duration).to eq 0
    end

    it "should parse expiry date" do
      expect(subject.expires_at).to eq DateTime.new 2025, 5, 12, 19, 3, 1
    end

    it "should parse status" do
      expect(subject.status).to eq 1
    end

    it "should parse scope" do
      expect(subject.scope).to eq "FB=36_40"
    end

    it "should parse resource URI" do
      expect(subject.resource_uri).to eq "https://services.greenbuttondata.org/DataCustodian/espi/1_1/resource/ApplicationInformation/2"
    end

    it "should parse authorization URI" do
      expect(subject.authorization_uri).to eq "https://services.greenbuttondata.org/DataCustodian/espi/1_1/resource/Authorization/4"
    end

    describe "#active?" do
      it "should return true if status is not 0" do
        expect(subject.active?).to eq true
      end
    end
  end
end
