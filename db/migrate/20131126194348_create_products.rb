class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :rls_code
      t.integer :product_group_id
      t.integer :inn_id
      t.integer :form_id
      t.integer :dose_id
      t.integer :pack_id
      t.integer :company_id
      t.string :ean

      t.timestamps
    end

    add_index :products, :product_group_id
    add_index :products, :inn_id
    add_index :products, :form_id
    add_index :products, :dose_id
    add_index :products, :pack_id
    add_index :products, :company_id
    add_index :products, :ean
  end
end
