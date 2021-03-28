require 'spec_helper'

describe GreenButtonData::Parser::CustomerAgreement do
  context 'PG&E namespace' do
    let(:feed) { GreenButtonData::Feed }
    let :customer_agreement do
      feed.parse(pge_retail_customer).entries[3].content.customer_agreement
    end
    subject { customer_agreement }

    it 'parses customer agreement id' do
      expect(subject.customer_agreement_id).to eq '1112392222'
    end

    it 'parses type' do
      expect(subject.type).to eq 'AGR'
    end

    it 'parses service agreement status' do
      expect(subject.doc_status).
        to be_an_instance_of GreenButtonData::Parser::DocStatus

      expect(subject.doc_status.value).to eq 'Active'
    end

    it 'parses sign date' do
      expect(subject.sign_date).to eq(1_376_550_000)
    end
  end
end
