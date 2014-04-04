class Item < ActiveRecord::Base
  validates :description, presence: true
  validates :price, presence: true, numericality: true
  has_many :sales, inverse_of: :item, dependent: :restrict_with_exception
  has_many :customers, through: :sales
  has_many :merchants, through: :sales
end
