class CreateRlsProductsTable < ActiveRecord::Migration
  def change
 		# RLS dictionary
    create_table :rls_products do |t|
			t.integer :code
			t.text	  :name
			t.string  :category
			t.text	  :product_group_type
			t.string  :product_form
			t.string  :dose
			t.string  :pack
			t.string  :company
			t.string  :country
			t.text	  :inn
			t.integer	:ean, limit: 8
      t.timestamps
    end

    add_index :rls_products, :code, unique: true
  end
end
