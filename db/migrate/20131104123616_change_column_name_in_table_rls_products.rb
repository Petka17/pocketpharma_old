chclass ChangeColumnNameInTableRlsProducts < ActiveRecord::Migration
  def change
  	rename_column :rls_products, :type, :product_type
  	rename_column :rls_products, :form, :product_form
  end
end