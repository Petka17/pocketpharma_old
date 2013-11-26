class ProductsController < ApplicationController

	def index
  	@products = Product.paginate(page: params[:page])
  end

  def import
  	Product.update
		redirect_to products_path
  end
end
