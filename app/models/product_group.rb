class ProductGroup < ActiveRecord::Base
	has_many :product
	belongs_to :group_type
end
