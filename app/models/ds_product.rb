class DsProduct < ActiveRecord::Base

	has_many :product_prices
	has_many :scores
	has_many :products, through: :scores
	belongs_to :product

	def name_reg
		/^([A-ZА-Я0-9][A-Za-zА-Яа-я0-9VIXХ\/\.0-9\-!\+\(\),]*( [A-ZА-Я0-9][A-Za-zА-Яа-я0-9VIXХ\/\.0-9\-!\+\(\),]*)*)+(?=(\s))/.match(full_name).to_s
	end	

	def company_reg
		/(?<= [А-Я]{3} ).+/.match(full_name).to_s
	end

	def country_code_reg
		/[А-Я]{3}(?= )/.match(full_name).to_s
	end

	def pack_param_reg
		/(?<=#{name_reg.gsub('+', '\+')} ).+(?= [А-Я]{3} )/.match(full_name).to_s
	end
#  (?<=^([A-ZА-Я0-9][A-Za-zА-Яа-я0-9VIXХ\/\.0-9\-!\+\(\),]*( [A-ZА-Я0-9][A-Za-zА-Яа-я0-9VIXХ\/\.0-9\-!\+\(\),]*)*)+(?=(\s))\s).+(?= [А-Я]{3})
end
