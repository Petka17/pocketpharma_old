class AddAcceptFlagToDsProduct < ActiveRecord::Migration
  def change
  	add_column :ds_products, :approved_flg, :boolean, default: false
  end
end
