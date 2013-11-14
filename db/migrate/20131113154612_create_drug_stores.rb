class CreateDrugStores < ActiveRecord::Migration
  def change
    create_table :drug_stores do |t|
			t.integer		:external_id
			t.string		:name
			t.string		:address
			t.string		:working_hours
			t.string		:sec_code

      t.timestamps
    end

    add_index :drug_stores, :external_id
  end
end
