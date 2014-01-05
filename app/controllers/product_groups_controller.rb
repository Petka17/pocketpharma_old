class ProductGroupsController < ApplicationController

	def index
		@product_groups = ProductGroup.paginate(page: params[:page])
	end

	def show
		@product_group = ProductGroup.find(params[:id])
		@products = @product_group.products.paginate(page: params[:page])
	end

end
