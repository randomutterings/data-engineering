require 'spec_helper'

describe Sale do
  it { should validate_presence_of(:customer_id) }
  it { should validate_presence_of(:merchant_id) }
  it { should validate_presence_of(:item_id) }
  it { should validate_presence_of(:count) }
  it { should validate_numericality_of(:count).only_integer }
  it { should validate_presence_of(:price) }
  it { should validate_numericality_of(:price) }
  it { should belong_to :customer }
  it { should belong_to :merchant }
  it { should belong_to :item }
  it { should belong_to :import }
end
