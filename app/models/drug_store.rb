class DrugStore < ActiveRecord::Base
	has_many :product_price, foreign_key: "drugstore_id", 
													 dependent: :destroy,
													 class_name: "ProductPrice"
end
