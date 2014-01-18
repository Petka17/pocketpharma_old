class RlsProductsController < ApplicationController
  
  def index
  	@rls_products = RlsProduct.paginate(page: params[:page])
  end

end
