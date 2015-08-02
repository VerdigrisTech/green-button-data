require "spec_helper"

describe GreenButtonData::Parser::LocalTimeParameters do
  context "espi namespace" do
    let(:feed) { GreenButtonData::Parser::Feed }
    let :local_time_parameters do
      feed.parse(espi_local_time_parameters)
          .entries
          .first
          .content
          .local_time_parameters
    end

    subject { local_time_parameters }

    it "should parse DST start rule" do
      expect(subject.dst_start_rule).to eq 0x360e2000
    end

    it "should parse DST end rule" do
      expect(subject.dst_end_rule).to eq 0xb40e2000
    end

    it "should parse DST offset" do
      expect(subject.dst_offset).to eq 3600
    end

    it "should parse timezone offset" do
      expect(subject.tz_offset).to eq -18000
    end

    describe "#dst_starts_at" do
      it "should return DateTime object representation of DST rule" do
        expect(subject.dst_starts_at(2015)).to eq DateTime.new 2015, 3, 8, 2
      end
    end

    describe "#dst_ends_at" do
      it "should return DateTime object representation of DST rule" do
        expect(subject.dst_ends_at(2015)).to eq DateTime.new 2015, 11, 1, 2
      end
    end

    describe "#total_offset" do
      it "should return total offset from DST and timezone offsets in seconds" do
        expect(subject.total_offset).to eq -14400
      end
    end

    describe "#total_offset_hours" do
      it "should return total offset in hours" do
        expect(subject.total_offset_hours).to eq -4
      end
    end
  end
end
