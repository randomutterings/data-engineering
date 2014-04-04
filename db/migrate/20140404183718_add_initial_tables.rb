class AddInitialTables < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
    end

    create_table :merchants do |t|
      t.string :name
      t.string :address
    end

    create_table :items do |t|
      t.string :description
      t.decimal :price
    end

    create_table :sales do |t|
      t.integer :import_id
      t.integer :customer_id
      t.integer :merchant_id
      t.integer :item_id
      t.integer :count
      t.decimal :price
    end

    create_table :imports do |t|
      t.attachment :tsv
      t.timestamps
    end
  end
end
