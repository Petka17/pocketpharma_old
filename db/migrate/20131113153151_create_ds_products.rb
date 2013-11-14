class CreateDsProducts < ActiveRecord::Migration
  def change
    create_table :ds_products do |t|
			t.integer		:external_id
			t.string 		:full_name
			t.integer		:rls_code
			t.float 		:ave_price
			t.string 		:ean

      t.timestamps
    end

    add_index :ds_products, :external_id
    add_index :ds_products, :rls_code
    add_index :ds_products, :ean
  end
end
