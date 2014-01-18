class Drugstore < ActiveRecord::Base
	has_many :product_prices, dependent: :destroy
end