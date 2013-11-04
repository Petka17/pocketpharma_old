class AddIndexToRlsProductTable < ActiveRecord::Migration
  def change
    add_index :rls_products, :code, unique: true
  end
end
