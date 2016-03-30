require "spec_helper"

describe GreenButtonData::Parser::CustomerAgreement do
  context "PG&E namespace" do
    let(:feed) { GreenButtonData::Feed }
    let :customer_agreement do
      feed.parse(pge_retail_customer).entries.last.content.customer_agreement
    end
    subject { customer_agreement }
    it "should parse customer_agreement_id" do
      expect(subject.customer_agreement_id).to eq '1112392222'
    end
  end
end
