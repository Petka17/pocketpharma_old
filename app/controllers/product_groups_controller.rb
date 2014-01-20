class ProductGroupsController < ApplicationController

	def index
		@product_groups = ProductGroup.where(search_str).paginate(page: params[:page])
	end

	def show
		@product_group = ProductGroup.find(params[:id])
		@products = @product_group.products.paginate(page: params[:page])
	end

	def edit
		@product_group = ProductGroup.find(params[:id])
		@product_group.update_attribute(:alias, params[:alias])
		redirect_to @product_group
	end

	private

	  def search_str
	  	params[:search].nil? ? "id is not null" : "name LIKE '%#{params[:search]}%'"
	  end		

end
