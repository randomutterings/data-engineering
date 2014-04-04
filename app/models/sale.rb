class Sale < ActiveRecord::Base
  validates_presence_of :customer_id, :merchant_id, :item_id
  validates :count, presence: true, numericality: { only_integer: true }
  validates :price, presence: true, numericality: true
  belongs_to :import, inverse_of: :sales
  belongs_to :customer, inverse_of: :sales
  belongs_to :merchant, inverse_of: :sales
  belongs_to :item, inverse_of: :sales
  delegate :name, to: :customer, prefix: true
  delegate :name, to: :merchant, prefix: true
  delegate :address, to: :merchant, prefix: true
  delegate :description, to: :item, prefix: true
end
