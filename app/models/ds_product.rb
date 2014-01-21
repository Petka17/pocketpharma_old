class DsProduct < ActiveRecord::Base
	has_many :product_prices
	has_many :scores
	has_many :products, through: :scores
	belongs_to :product

	attr_reader :product_name

	def name
		/^([А-Я][А-Яа-яVIXХ\.0-9-]*( [А-Я][А-Яа-яVIXХ\.0-9-]*)*)+(?=\s)/.match(full_name)
	end

end
