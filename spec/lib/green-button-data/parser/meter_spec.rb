require 'spec_helper'

describe GreenButtonData::Parser::Meter do
  context 'PG&E namespace' do
    let(:feed) { GreenButtonData::Feed }
    let :meter do
      feed.parse(pge_retail_customer).entries[4].content.meter
    end

    subject { meter }

    it 'parses type' do
      expect(subject.meter_type).to eq 'EMTR 12S/XP/CL200/3W/5Dials'
    end

    it 'parses serial number' do
      expect(subject.meter_serial_number).to eq '1121183459'
    end

    it 'parses interval length' do
      expect(subject.meter_interval_length).to eq 900
    end
  end
end
