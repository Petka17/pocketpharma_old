class ChangeProductIdColumnNameForTableProductPrice < ActiveRecord::Migration
  def change
  	rename_column :product_prices, :product_id, :ds_product_id
  end
end
