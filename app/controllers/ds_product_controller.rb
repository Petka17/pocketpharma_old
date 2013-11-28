class DsProductController < ApplicationController

	def index
		@ds_products = DsProduct.paginate(page: params[:page])
	end

	def update_db
		DsProductWorker.perform_async
		redirect_to ds_product_index_path
	end

end
