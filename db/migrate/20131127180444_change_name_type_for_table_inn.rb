class ChangeNameTypeForTableInn < ActiveRecord::Migration
  def change
  	change_column :inns, :name, :text
  end
end
