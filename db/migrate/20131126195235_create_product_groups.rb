class CreateProductGroups < ActiveRecord::Migration
  def change
    create_table :product_groups do |t|
      t.string :name
      t.string :category
      t.integer :type_id

      t.timestamps
    end
  end
end
