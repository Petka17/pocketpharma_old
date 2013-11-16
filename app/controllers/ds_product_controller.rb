class DsProductController < ApplicationController

	def index
		@ds_products = DsProduct.all
	end

	def update_db
		ProductPrice.where(product_id: nil).each do |pp|
			pp.save
		end
		redirect_to ds_product_index_path
	end

end
