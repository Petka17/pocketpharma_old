class CreateDoses < ActiveRecord::Migration
  def change
    create_table :doses do |t|
      t.string :name

      t.timestamps
    end
  end
end
