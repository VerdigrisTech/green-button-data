require "spec_helper"

describe GreenButtonData::Parser::UsageSummary do
  let(:feed) { GreenButtonData::Feed }

  context "espi namespace" do
    let :usage_summary do
      feed.parse(espi_usage_summaries).entries.first.content.usage_summary
    end

    subject { usage_summary }

    it "should parse billing period" do
      expect(subject.billing_period).to be_an GreenButtonData::Parser::Interval
    end

    it "should parse bill last period" do
      expect(subject.bill_last_period).to eq 6752000
    end

    it "should parse bill to date" do
      expect(subject.bill_to_date).to eq 4807000
    end

    it "should parse cost additional last period" do
      expect(subject.cost_additional_last_period).to eq 0
    end

    it "should parse currency" do
      expect(subject.currency).to eq :usd
    end

    it "should parse overall consumption last period" do
      expect(subject.overall_consumption_last_period).
      to be_a GreenButtonData::Parser::SummaryMeasurement
    end

    it "should parse current billing period overall consumption" do
      expect(subject.current_billing_period_over_all_consumption).
      to be_a GreenButtonData::Parser::SummaryMeasurement
    end

    it "should parse quality of reading" do
      expect(subject.quality_of_reading).to eq :raw
    end

    it "should parse status timestamp" do
      expect(subject.status_time_stamp).to eq DateTime.new 2014, 3, 21, 4
    end
  end

  context "PG&E namespace" do
    let :usage_summary do
      feed.parse(pge_usage_summaries).entries.first.content.usage_summary
    end

    subject { usage_summary }

    it "should parse billing period" do
      expect(subject.billing_period).to be_a GreenButtonData::Parser::Interval
    end

    it "should parse overall consumption last period" do
      expect(subject.overall_consumption_last_period).
      to be_a GreenButtonData::Parser::SummaryMeasurement
    end

    it "should parse quality of reading" do
      expect(subject.quality_of_reading).
      to eq :validated
    end

    it "should parse status time stamp" do
      expect(subject.status_time_stamp).
      to eq DateTime.new 2015, 8, 20, 22, 32, 37
    end

    it "should parse commodity" do
      expect(subject.commodity).to eq :electricity_secondary_metered
    end
  end

  context "deprecated element name" do
    let :electric_power_usage_summary do
      feed.parse(espi_electric_power_usage_summary).entries.first.content.electric_power_usage_summary
    end

    subject { electric_power_usage_summary }

    it "should raise deprecation warnings" do
      expect {
        subject
      }.to warn("[DEPRECATED] ElectricPowerUsageSummary element is deprecated by OpenESPI Green Button Data standards. Please migrate to UsageSummary in the future.")
    end
  end
end
