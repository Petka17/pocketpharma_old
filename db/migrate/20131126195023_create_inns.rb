class CreateInns < ActiveRecord::Migration
  def change
    create_table :inns do |t|
      t.string :name

      t.timestamps
    end
  end
end
