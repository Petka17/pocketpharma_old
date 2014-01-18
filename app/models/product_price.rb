class ProductPrice < ActiveRecord::Base
	belongs_to :drugstore
	belongs_to :ds_product
end