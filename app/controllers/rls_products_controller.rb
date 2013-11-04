class RlsProductsController < ApplicationController
  
  def index
  	@rls_products = RlsProduct.all
  end

  def import
  	RlsProduct.import(params[:file])
		redirect_to root_path
  end
end
