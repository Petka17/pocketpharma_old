class DsProduct < ActiveRecord::Base
	has_many :product_prices
	has_many :scores
	has_many :products, through: :scores
end
