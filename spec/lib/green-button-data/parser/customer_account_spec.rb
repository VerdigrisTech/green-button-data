require 'spec_helper'

describe GreenButtonData::Parser::CustomerAccount do
  context 'PG&E namespace' do
    let(:feed) { GreenButtonData::Feed }
    let :customer_account do
      feed.parse(pge_retail_customer).entries[2].content.customer_account
    end

    subject { customer_account }

    it 'parses account ID' do
      expect(subject.account_id).to eq '1687340014'
    end
  end
end
