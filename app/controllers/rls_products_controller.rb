class RlsProductsController < ApplicationController
  
  def index
  	@rls_products = RlsProduct.paginate(page: params[:page])
  end

  def import
  	RlsProduct.import(params[:file])
  	# MedluxWorker.perform_async(params[:file])
		redirect_to rls_products_path
  end
end
