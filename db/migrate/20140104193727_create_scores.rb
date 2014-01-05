class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
    	t.integer :product_id
    	t.integer :ds_product_id
    	t.float		:score
      t.timestamps
    end
  end
end
