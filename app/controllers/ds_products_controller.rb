class DsProductsController < ApplicationController

	helper_method :sort_column, :sort_direction

	def index
		@ds_products = DsProduct.where(search_str).order(sort_column + " " + sort_direction).paginate(page: params[:page])
	end

	def show
		@ds_product = DsProduct.find(params[:id])
		update_score_table unless search_pg_str.nil?
		@ds_product.product_id = params[:product_id]
	 	@scores = @ds_product.scores
	end

	private
  
	  def sort_column
	    DsProduct.column_names.include?(params[:sort]) ? params[:sort] : "avg_price"
	  end
	  
	  def sort_direction
	    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
	  end

	  def search_str
	  	params[:search].nil? ? "id is not null" : "full_name LIKE '%#{params[:search]}%'"
	  end

	  def search_pg_str
	  	params[:search].nil? ? nil : "name LIKE '#{params[:search]}%'"
	  end

	  def update_score_table
			@ds_product.scores.delete_all

			ProductGroup.where(search_pg_str).each do |pg|
				pg.products.each do |p|
					s = Score.new
					s.product_id = p.id
					s.ds_product_id = params[:id]
					s.save
				end
			end

			@ds_product = DsProduct.find(params[:id])
		end

end
