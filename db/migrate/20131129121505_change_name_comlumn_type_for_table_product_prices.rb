class ChangeNameComlumnTypeForTableProductPrices < ActiveRecord::Migration
  def change
		change_column :product_prices, :full_name, :text
  end
end
