class CreateProductPrices < ActiveRecord::Migration
  def change
    create_table :product_prices do |t|
			t.integer 	:product_id
			t.integer 	:drugstore_id
			t.integer 	:external_id
			t.float 		:price
			t.integer 	:amount
			t.string 		:full_name
			t.string 		:ean

      t.timestamps
    end

    add_index :product_prices, [:product_id, :drugstore_id], unique: true
    add_index :product_prices, :external_id
    add_index :product_prices, :full_name
    add_index :product_prices, :ean
  end
end
