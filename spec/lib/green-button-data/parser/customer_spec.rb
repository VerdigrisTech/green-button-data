require 'spec_helper'

describe GreenButtonData::Parser::Customer do
  context 'PG&E namespace' do
    let(:feed) { GreenButtonData::Feed }
    let :customer do
      feed.parse(pge_retail_customer).entries[0].content.customer
    end

    subject { customer }

    it 'parses customer name' do
      expect(subject.name).to eq 'ACME INDUSTRIES'
    end
  end
end
