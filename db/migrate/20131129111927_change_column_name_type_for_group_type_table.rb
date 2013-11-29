class ChangeColumnNameTypeForGroupTypeTable < ActiveRecord::Migration
  def change
  	change_column :group_types, :name, :text
  end
end
