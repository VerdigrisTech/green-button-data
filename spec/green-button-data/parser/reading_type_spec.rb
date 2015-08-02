require "spec_helper"

describe GreenButtonData::Parser::ReadingType do
  context "espi namespace" do
    let(:feed) { GreenButtonData::Parser::Feed }
    let :reading_type do
      feed.parse(espi_reading_type).entries.first.content.reading_type
    end

    subject { reading_type }

    it "should parse accumulation behavior" do
      expect(subject.accumulation_behaviour).to eq :delta_data
    end

    it "should parse commodity" do
      expect(subject.commodity).to eq :electricity_secondary_metered
    end

    it "should parse consumption tier" do
      expect(subject.consumption_tier).to eq nil
    end

    it "should parse currency" do
      expect(subject.currency).to eq :usd
    end

    it "should parse data qualifier" do
      expect(subject.data_qualifier).to eq :normal
    end

    it "should parse flow direction" do
      expect(subject.flow_direction).to eq :forward
    end

    it "should parse interval length" do
      expect(subject.interval_length).to eq 300
    end

    it "should parse measurement kind" do
      expect(subject.kind).to eq :energy
    end

    it "should parse phase" do
      expect(subject.phase).to eq :s12_n
    end

    it "should parse power of ten multiplier" do
      expect(subject.power_of_ten_multiplier).to eq 1
    end

    it "should parse time attribute" do
      expect(subject.time_attribute).to eq :none
    end

    it "should parse unit of measurement" do
      expect(subject.uom).to eq :Wh
    end

    it "should parse cpp" do
      expect(subject.cpp).to eq nil
    end

    it "should parse interharmonic" do
      expect(subject.interharmonic).to eq nil
    end

    it "should parse measuring period" do
      expect(subject.measuring_period).to eq nil
    end

    it "should parse argument" do
      expect(subject.argument).to eq nil
    end
  end
end
