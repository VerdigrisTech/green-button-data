require "spec_helper"

describe Fixnum do
  describe "#digits" do
    it "should return number of digits for a fixed number" do
      expect(1234.digits).to eq 4
    end

    it "should return 1 for 0" do
      expect(0.digits).to eq 1
    end
  end
end
