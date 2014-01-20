class AddAliases < ActiveRecord::Migration
  def change
  	add_column :product_groups, :alias, :string
  	add_index :product_groups, :alias

  	add_column :group_types, :alias, :string
  	add_index :group_types, :alias

  	add_column :inns, :alias, :string
  	add_index :inns, :alias

  	add_column :companies, :alias, :string
  	add_index :companies, :alias

  	add_column :countries, :alias, :string
  	add_index :countries, :alias
  end
end
