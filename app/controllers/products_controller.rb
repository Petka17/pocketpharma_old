class ProductsController < ApplicationController

	def index
  	@products = Product.paginate(page: params[:page])
  end

  def update_db
  	# Product.update_db
  	ProductWorker.perform_async
		redirect_to products_path
  end

end
