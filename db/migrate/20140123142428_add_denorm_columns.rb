class AddDenormColumns < ActiveRecord::Migration
  def change
   	add_column :ds_products, :name, :string
  	add_column :ds_products, :company, :string
  	add_column :ds_products, :country_code, :string
  	add_column :ds_products, :pack_param, :string
  end
end
