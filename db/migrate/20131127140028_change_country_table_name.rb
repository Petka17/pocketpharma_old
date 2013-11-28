class ChangeCountryTableName < ActiveRecord::Migration
  def change
  	rename_table :counties, :countries
  end
end
