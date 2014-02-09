class Product < ActiveRecord::Base
	
	belongs_to :product_group
	belongs_to :form
	belongs_to :dose
	belongs_to :pack
	belongs_to :inn
	belongs_to :company
	belongs_to :rls_product, class_name: "RlsProduct", 
													 foreign_key: "rls_code",
													 primary_key: "code"

	attr_reader :full_name, 
							:pack_param, 
							:country_name,
							:company_name, 
							:product_group_name,
							:product_group_category,
							:product_group_type,
							:inn_name

	def full_name
		str = product_group.name 
		str += ' ' + form.name unless form.nil?
		str += ' ' + dose.name unless dose.nil?
		str += ' ' + pack.name unless pack.nil?
		# str += ' ' + country_name
		# str += ' ' + company.country.name unless company.nil? || company.country.nil?
		# str += ' ' + company_name
	end

	def pack_param
		form_name + ' ' + dose_name + ' ' + pack_name
	end

	def form_name
		form.nil? ? "" : form.name
	end

	def dose_name
		dose.nil? ? "" : dose.name
	end

	def pack_name
		pack.nil? ? "" : pack.name
	end

	def country_name
		company.country.name unless company.nil? || company.country.nil?
	end

	def company_name
		company.name unless company.nil?
	end

	def product_group_name
		product_group.name unless product_group.nil?
	end

	def product_group_category
		product_group.category unless product_group.nil?
	end

	def product_group_type
		product_group.group_type.name unless product_group.nil? || product_group.group_type.nil?
	end
	
	def inn_name
		inn.name unless inn.nil?
	end

end
