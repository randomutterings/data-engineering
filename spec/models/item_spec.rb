require 'spec_helper'

describe Item do
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:price) }
  it { should validate_numericality_of(:price) }
  it { should have_many :merchants }
  it { should have_many :customers }
  it { should have_many :sales }

  context "with sales" do
    subject { Item.new }

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
