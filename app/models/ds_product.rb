class DsProduct < ActiveRecord::Base
	has_many :product_price, foreign_key: "product_id",
													 class_name: "ProductPrice"
end
