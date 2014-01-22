class Score < ActiveRecord::Base
	belongs_to :product, -> { includes :product_group}
end