class DsProductController < ApplicationController

	def index
		@ds_products = DsProduct.paginate(page: params[:page])
	end

	def update_db
		DsProductWorker.perform_async
		redirect_to ds_product_index_path
	end

	def show
		@ds_product = DsProduct.find(params[:id])
	end

  def get_product_group_list
  	@ds_product = DsProduct.find(params[:product][:id])
  	@product_groups = ProductGroup.get_similar_products(@ds_product.full_name)#.paginate(page: params[:page])

  	render 'show'
  end

end
