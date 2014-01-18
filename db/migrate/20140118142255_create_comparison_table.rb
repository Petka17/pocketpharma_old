class CreateComparisonTable < ActiveRecord::Migration
  def change
    # Сomparison table
    create_table :scores do |t|
    	t.integer :product_id
    	t.integer :ds_product_id
    	t.float		:form_score
    	t.float		:dose_score
    	t.float		:pack_score
    	t.float		:country_score
    	t.float		:company_score
    	t.float		:full_score
      t.timestamps
    end

    add_index :scores, [:product_id, :ds_product_id], unique: true
    add_index :scores, :form_score
    add_index :scores, :dose_score
    add_index :scores, :pack_score
    add_index :scores, :country_score
    add_index :scores, :company_score
    add_index :scores, :full_score
  end
end
