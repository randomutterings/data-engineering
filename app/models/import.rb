require 'csv'

class Import < ActiveRecord::Base
  has_many :sales
  has_attached_file :tsv
  validates_attachment :tsv, :presence => true,
    :content_type => { :content_type => ['text/tab-separated-values', 'text/plain'] }

  def process
    csv_options = { headers: true,
                    header_converters: [:downcase, :symbol],
                    col_sep: "\t",
                    skip_blanks: true }

    CSV.foreach(tsv.path, csv_options) do |csv|
      customer = Customer.create!(name: csv[:purchaser_name])
      merchant = Merchant.create!(name: csv[:merchant_name],
                                  address: csv[:merchant_address])
      item = Item.create!(description: csv[:item_description],
                          price: csv[:item_price])
      sales.create!(customer: customer,
                    merchant: merchant,
                    item: item,
                    count: csv[:purchase_count],
                    price: csv[:item_price])
    end
    true
  end

  def total
    sales.sum("count * price")
  end

end
