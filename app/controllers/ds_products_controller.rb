class DsProductsController < ApplicationController

	def index
		@ds_products = DsProduct.paginate(page: params[:page])
	end

	def update
		@ds_products = DsProduct.paginate(page: params[:page])
		redirect_to @ds_products
	end

	def edit
		@ds_product = DsProduct.find(params[:id])
	 	@products = Product.get_similar_products(@ds_product.full_name)
	end

	def update_db
		DsProductWorker.perform_async
		redirect_to ds_product_index_path
	end

end
