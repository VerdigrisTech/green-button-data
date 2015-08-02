require "spec_helper"

describe GreenButtonData::Parser::UsagePoint do
  context "espi namespace" do
    let(:feed) { GreenButtonData::Feed }
    let :usage_point do
      feed.parse(espi_usage_point).entries.first.content.usage_point
    end

    subject { usage_point }

    it "should parse kind" do
      expect(subject.kind).to eq 0
    end

    describe "#service_category" do
      it "should return service category as a symbol" do
        expect(subject.service_category).to eq :electricity
      end
    end
  end
end
