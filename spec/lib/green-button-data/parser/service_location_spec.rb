require "spec_helper"

describe GreenButtonData::Parser::ServiceLocation do
  context "PG&E namespace" do
    let(:feed) { GreenButtonData::Feed }
    let :service_location do
      feed.parse(pge_retail_customer).entries[1].content.service_location
    end

    subject { service_location }
    it "should parse service_location" do
      expect(subject.main_address).
        to be_an_instance_of GreenButtonData::Parser::MainAddress
      expect(subject.main_address.street_detail).
        to be_an_instance_of GreenButtonData::Parser::StreetDetail
      expect(subject.main_address.town_detail).
        to be_an_instance_of GreenButtonData::Parser::TownDetail
      expect(subject.main_address.street_detail.address_general).to eq '140 HAN RD'
      expect(subject.main_address.town_detail.name).to eq 'KING CITY'
      expect(subject.main_address.town_detail.code).to eq '95101'
      expect(subject.main_address.town_detail.state_or_province).to eq 'CA'
      expect(subject.main_address.town_detail_info).to eq 'KING CITY,CA,95101'
      expect(subject.main_address.address_general).to eq '140 HAN RD'
      expect(subject.main_address.to_s).to eq '140 HAN RD,KING CITY,CA,95101'
    end
  end
end
