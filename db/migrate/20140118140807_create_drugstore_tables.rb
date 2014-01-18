class CreateDrugstoreTables < ActiveRecord::Migration
  def change
  	# Drugstore list
    create_table :drugstores do |t|
			t.integer		:external_id
			t.string		:name
			t.string		:address
			t.string		:working_hours
			t.string		:phone
			t.datetime	:data_last_update
			t.integer		:product_num
      t.timestamps
    end

    add_index :drugstores, :external_id

    # Price list
    create_table :product_prices do |t|
			t.integer 	:ds_product_id
			t.integer 	:drugstore_id
			t.integer 	:external_id
			t.text	 		:full_name
			t.float 		:price
			t.integer 	:amount
      t.timestamps
    end

    # Product from Drugstore 
    create_table :ds_products do |t|
			t.integer		:external_id
			t.integer		:product_id
			t.string 		:full_name
			t.float 		:max_price
			t.float 		:min_price
			t.float 		:avg_price
			t.integer		:drugstore_count

      t.timestamps
    end

    add_index :ds_products, :external_id
    add_index :ds_products, :product_id
  end
end
