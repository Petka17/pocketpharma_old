class Product < ActiveRecord::Base
	belongs_to :form
	belongs_to :dose
	belongs_to :pack
end
