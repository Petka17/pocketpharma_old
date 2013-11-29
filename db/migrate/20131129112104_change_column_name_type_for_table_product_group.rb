class ChangeColumnNameTypeForTableProductGroup < ActiveRecord::Migration
  def change
  	change_column :product_groups, :name, :text
  end
end
