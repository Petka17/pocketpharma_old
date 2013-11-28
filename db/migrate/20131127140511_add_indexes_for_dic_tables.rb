class AddIndexesForDicTables < ActiveRecord::Migration
  def change
  	add_index :group_types, :name, unique: true
  	add_index :product_groups, [:name, :category, :type_id], unique: true

  	add_index :forms, :name, unique: true
  	add_index :doses, :name, unique: true
  	add_index :packs, 	:name, unique: true

  	add_index :inns, :name, unique: true

  	add_index :companies, [:name, :country_id], unique: true
  end
end
