class Merchant < ActiveRecord::Base
  validates_presence_of :name, :address
  has_many :sales, inverse_of: :merchant, dependent: :restrict_with_exception
  has_many :items, through: :sales
  has_many :customers, through: :sales
end
