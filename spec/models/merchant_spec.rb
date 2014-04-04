require 'spec_helper'

describe Merchant do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:address) }
  it { should have_many :items }
  it { should have_many :customers }
  it { should have_many :sales }

  context "with sales" do
    subject { Merchant.new }

    before(:each) do
      subject.sales << Sale.new
    end

    it "should restrict destruction" do
      expect {
        subject.destroy
      }.to raise_error(ActiveRecord::DeleteRestrictionError)
    end
  end

end
