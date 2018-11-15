require "spec_helper"

describe GreenButtonData::Parser::CostAdditionalDetailLastPeriod do
  context "PG&E namespace" do
    let(:feed) { GreenButtonData::Feed }

    let(:cost_additional_details) do
      feed.parse(pge_usage_summaries).entries.first.content.usage_summary.cost_additional_detail_last_periods
    end

    subject { cost_additional_details }

    it 'generates an array of detail objects' do
      expect(subject).to be_an_instance_of(Array)

      subject.each do |obj|
        expect(obj).to be_a(GreenButtonData::Parser::CostAdditionalDetailLastPeriod)
      end
    end

    it 'parses costs' do
      expect(subject.map(&:cost)).to eq([
        12.0,
        36.0,
        0.77,
        4.8,
        0.01
      ])
    end

    it 'parses notes' do
      expect(subject.map(&:note)).to eq([
        'Part Peak Energy Charge',
        'Off Peak Energy Charge',
        'Max Demand Charge',
        'Customer Charge',
        'Energy Commission Tax'
      ])
    end

    it 'parses measurement values' do
      expect(subject.map(&:power_of_ten_multiplier)).to eq([
        :m,
        :m,
        :m,
        :m,
        :m
      ])

      expect(subject.map(&:uom)).to eq([
        :Wh,
        :Wh,
        :W,
        :Wh,
        :Wh
      ])

      expect(subject.map(&:value)).to eq([
        100_000.0,
        400_000.0,
        960.0,
        4_000.0,
        0
      ])
    end

    it 'parses classification code' do
      expect(subject.map(&:item_kind)).to eq([
        3,
        3,
        3,
        4,
        5
      ])
    end

    it 'parses the per unit cost, i.e. rate' do
      expect(subject.map(&:unit_cost)).to eq([
        12000,
        9000,
        603000,
        120000,
        nil
      ])
    end

    it 'parses the item period values' do
      expect(subject.map(&:item_period).map(&:duration)).to eq([
        2505600,
        2505600,
        2505600,
        2505600,
        2505600
      ])

      expect(subject.map(&:item_period).map(&:start)).to eq([
        1434006000,
        1434006000,
        1434006000,
        1434006000,
        1434006000
      ])
    end
  end
end
