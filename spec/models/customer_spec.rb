require 'spec_helper'

describe Customer do
  it { should validate_presence_of(:name) }
  it { should have_many :items }
  it { should have_many :merchants }
  it { should have_many :sales }

  context "with sales" do
    subject { Customer.new }

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
