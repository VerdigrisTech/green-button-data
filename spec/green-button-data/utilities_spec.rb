require "#{File.dirname(__FILE__)}/../spec_helper"

describe GreenButtonData::Utilities do
  before(:each) { @klass = Class.new { include GreenButtonData::Utilities } }

  describe "#parse_datetime" do
    it "should parse an ISO 8601 formatted datetime into DateTime" do
      time = @klass.new.parse_datetime "2015-10-21T16:21:00.0-07:00"
      expect(time.class).to eq DateTime
      expect(time).to eq DateTime.new 2015, 10, 21, 23, 21, 0
    end
  end

  describe "#normalize_epoch" do
    it "should normalize UNIX epoch in microseconds to seconds" do
      epoch = @klass.new.normalize_epoch 144546968100000
      expect(epoch).to eq 1445469681
    end

    it "should normalize UNIX epoch in milliseconds to seconds" do
      epoch = @klass.new.normalize_epoch 1445469681000
      expect(epoch).to eq 1445469681
    end

    it "should keep UNIX epoch in seconds" do
      epoch = @klass.new.normalize_epoch 1445469681
      expect(epoch).to eq 1445469681
    end
  end

  describe "#first_sunday_of" do
    it "should return the first Sunday of a given month" do
      date = @klass.new.first_sunday_of 2015, 10
      expect(date.day).to eq 4
    end
  end

  describe "#nth_weekday_of" do
    it "should return the Nth weekday of a given month" do
      third_wednesday = @klass.new.nth_weekday_of 2015, 10, 3, 3
      expect(third_wednesday.day).to eq 21
    end
  end
end
