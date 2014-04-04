class Customer < ActiveRecord::Base
  validates_presence_of :name
  has_many :sales, inverse_of: :customer, dependent: :restrict_with_exception
  has_many :items, through: :sales
  has_many :merchants, through: :sales
end
