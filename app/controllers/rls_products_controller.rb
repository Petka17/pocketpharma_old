class RlsProductsController < ApplicationController
  
  def index
  	@rls_products = RlsProduct.paginate(page: params[:page])
  end

	def clear_db
		RlsProduct.delete_all
		redirect_to rls_products_path, notice: "База данных отчищена"
	end

  def import
  	RlsProduct.mass_insert(params[:file])
		redirect_to rls_products_path, notice: "Файл загружен"
  end
end
