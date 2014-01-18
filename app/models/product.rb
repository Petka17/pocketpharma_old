class Product < ActiveRecord::Base
	
	belongs_to :product_group
	belongs_to :form
	belongs_to :dose
	belongs_to :pack
	belongs_to :inn
	belongs_to :company

end
