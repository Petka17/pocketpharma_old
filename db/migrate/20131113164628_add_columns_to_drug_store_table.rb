class AddColumnsToDrugStoreTable < ActiveRecord::Migration
  def change
  	add_column :drug_stores, :phone, :string
  	add_column :drug_stores, :data_last_update, :datetime
  end
end
