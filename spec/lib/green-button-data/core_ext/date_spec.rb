require "spec_helper"

describe Date do
  let(:local_date) { DateTime.new 2015, 10, 21, 16, 21, 21, '-7:00' }
  let(:utc_date) { DateTime.new 2015, 10, 21, 23, 21, 21 }

  describe "#utc" do
    it "should convert to UTC" do
      expect(local_date.utc).to eq DateTime.new 2015, 10, 21, 23, 21, 21
    end
  end

  describe "#local" do
    it "should convert to local time" do
      expect(utc_date.local).to eq DateTime.new 2015, 10, 21, 16, 21, 21, '-7:00'
    end
  end
end
