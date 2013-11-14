class AddDeleteFlagToProductPriceTable < ActiveRecord::Migration
  def change
  	add_column :product_prices, :delete_flag, :boolean, default: false
  end
end
