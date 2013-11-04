class CreateRlsProducts < ActiveRecord::Migration
  def change
    create_table :rls_products do |t|
			t.integer :code
			t.string  :name
			t.string  :category
			t.string  :type
			t.string  :form
			t.string  :dose
			t.string  :pack
			t.string  :company
			t.string  :country
			t.string  :inn
			t.string  :ean

      t.timestamps
    end
  end
end
