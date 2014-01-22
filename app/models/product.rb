class Product < ActiveRecord::Base
	
	belongs_to :product_group
	belongs_to :form
	belongs_to :dose
	belongs_to :pack
	belongs_to :inn
	belongs_to :company, -> { includes :country }

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
		str += ' ' + country_name
		str += ' ' + company_name
	end

	def pack_param
		str = ""
		str += form.name + ' ' unless form.nil?
		str += dose.name + ' ' unless dose.nil?
		str += pack.name + ' ' unless pack.nil?
		str.strip!
		str
	end

	def country_name
		company.country.name unless company.country.nil?
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
