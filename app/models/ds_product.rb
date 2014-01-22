class DsProduct < ActiveRecord::Base

	has_many :product_prices
	has_many :scores
	has_many :products, through: :scores
	belongs_to :product

	attr_reader :product_name, :company, :country_code, :pack_param

	def name
		/^([А-Я][А-Яа-яVIXХ\.0-9-]*( [А-ЯA-Z][А-Яа-яVIXХ\.0-9-]*)*)+(?=\s)/.match(full_name)
	end

	def company
		/(?<= [А-Я]{3} ).+/.match(full_name)
	end

	def country_code
		/[А-Я]{3}/.match(full_name)
	end

	def pack_param
		/(?<=#{name} ).+(?= [А-Я]{3})/.match(full_name)
	end
end
