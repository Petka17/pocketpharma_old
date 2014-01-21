class Product < ActiveRecord::Base
	
	belongs_to :product_group
	belongs_to :form
	belongs_to :dose
	belongs_to :pack
	belongs_to :inn
	belongs_to :company

	attr_reader :full_name

	def full_name
		@full_name = product_group.name + ' ' + form.name + ' ' + dose.name + ' ' + pack.name + ' ' + company.country.name + ' ' + company.name
		ean.nil? ? @full_name : @full_name + ' (' + ean.to_s + ')'
	end

end
