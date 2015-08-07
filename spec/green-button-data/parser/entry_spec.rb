require "spec_helper"

describe GreenButtonData::Parser::Entry do
  context "no namespace" do
    let(:feed) { GreenButtonData::Feed }
    let :entries do
      feed.parse(espi_usage_point)
          .entries
    end

    subject { entries.first }

    it "should parse id" do
      expect(subject.id).to eq "urn:uuid:c8c34b3a-d175-447b-bd00-176f60194de0"
    end

    it "should parse up" do
      expect(subject.up).to eq "https://services.greenbuttondata.org//DataCustodian/espi/1_1/resource/Subscription/5/UsagePoint"
    end

    it "should parse self" do
      expect(subject.self).to eq "https://services.greenbuttondata.org//DataCustodian/espi/1_1/resource/Subscription/5/UsagePoint/1"
    end

    it "should parse related" do
      expect(subject.related.size).to eq 3
      expect(subject.related).to all be_a String
    end
  end

  context "PG&E namespace" do
    let(:feed) { GreenButtonData::Feed }
    let :entries do
      feed.parse(pge_usage_point)
          .entries
    end

    subject { entries.first }

    it "should parse id" do
      expect(subject.id).to eq "00000000-0000-0000-0000-000000000002"
    end

    it "should parse up" do
      expect(subject.up).to eq "https://api.pge.com/GreenButtonConnect/espi/1_1/resource/Subscription/0/UsagePoint"
    end

    it "should parse self" do
      expect(subject.self).to eq "https://api.pge.com/GreenButtonConnect/espi/1_1/resource/Subscription/0/UsagePoint/1"
    end

    it "should parse related" do
      expect(subject.related.size).to eq 3
      expect(subject.related).to all be_a String
    end
  end
end
