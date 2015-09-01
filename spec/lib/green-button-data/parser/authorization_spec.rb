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
  end

  context "PG&E namespace" do
    let(:feed) { GreenButtonData::Feed }
    let :authorization do
      feed.parse(pge_authorization)
          .entries
          .first
          .content
          .authorization
    end

    subject { authorization }

    it "should parse authorized period" do
      expect(subject.authorized_period.start).to eq 1440585200
      expect(subject.authorized_period.duration).to eq 2519636580
    end

    it "should parse published period" do
      expect(subject.published_period.start).to eq 1395513200
      expect(subject.published_period.duration).to eq 2520267300
    end

    it "should parse expiry date" do
      expect(subject.expires_at).to eq DateTime.new 2015, 8, 27, 10, 7, 9
    end

    it "should parse status" do
      expect(subject.status).to eq 1
    end

    it "should parse scope" do
      expect(subject.scope).to eq "FB=1_3_4_5_8_13_14_15_18_19_31_32_35_37_38_39_40;IntervalDuration=900_3600;BlockDuration=Daily;HistoryLength=63072000;SubscriptionFrequency=Daily;AccountCollection=1;"
    end

    it "should parse resource URI" do
      expect(subject.resource_uri).to eq "https://api.pge.com/GreenButtonConnect/espi/1_1/resource/Subscription/0"
    end

    it "should parse authorization URI" do
      expect(subject.authorization_uri).to eq "https://api.pge.com/GreenButtonConnect/espi/1_1/resource/Authorization/0"
    end
  end
end
