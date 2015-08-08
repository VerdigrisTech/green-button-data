require "spec_helper"

describe GreenButtonData::Parser::IntervalBlock do
  context "espi namespace" do
    let(:feed) { GreenButtonData::Feed }
    let :interval_block do
      feed.parse(espi_interval_block).entries.first.content.interval_block
    end

    subject { interval_block }

    it "should parse interval" do
      expect(subject.interval).to be_an_instance_of GreenButtonData::Parser::Interval
    end

    it "should parse interval readings" do
      expect(subject.interval_readings.size).to eq 31
      expect(subject.interval_readings.first).to be_an_instance_of GreenButtonData::Parser::IntervalReading
    end

    describe "#duration" do
      it "should return the duration of the current interval block" do
        expect(subject.duration).to eq 2678400
      end
    end

    describe "#starts_at" do
      it "should return the start datetime" do
        expect(subject.starts_at).to eq DateTime.new 2013, 1, 1, 5
      end
    end

    describe "#ends_at" do
      it "should return the end datetime" do
        expect(subject.ends_at).to eq DateTime.new 2013, 2, 1, 5
      end
    end
  end

  context "PG&E namespace" do
    let(:feed) { GreenButtonData::Feed }
    let :interval_block do
      feed.parse(pge_interval_block).entries.last.content.interval_block
    end

    subject { interval_block }

    it "should parse interval" do
      expect(subject.interval).to be_an_instance_of GreenButtonData::Parser::Interval
    end

    it "should parse interval readings" do
      expect(subject.interval_readings.size).to eq 2280
      expect(subject.interval_readings.first).to be_an_instance_of GreenButtonData::Parser::IntervalReading
    end

    describe "#duration" do
      it "should return the duration of the current interval block" do
        expect(subject.duration).to eq 8208000
      end
    end

    describe "#starts_at" do
      it "should return the start datetime" do
        expect(subject.starts_at).to eq DateTime.new 2015, 4, 30, 7
      end
    end

    describe "#ends_at" do
      it "should return the end datetime" do
        expect(subject.ends_at).to eq DateTime.new 2015, 8, 3, 7
      end
    end
  end
end
