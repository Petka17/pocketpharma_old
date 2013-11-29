class ChangeColummTypesForRlsProductTable < ActiveRecord::Migration
  def change
  	change_column :rls_products, :name, :text
  	change_column :rls_products, :product_type, :text
  end
end
