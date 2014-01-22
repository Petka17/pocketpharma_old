class DsProductsController < ApplicationController

	helper_method :sort_column, :sort_direction

	def index
		@ds_products = DsProduct.where(search_str).order(sort_column + " " + sort_direction).paginate(page: params[:page])
	end

	def show
		@ds_product = DsProduct.find(params[:id])
		@ds_product.update_attribute(:product_id, product_id) unless product_id.nil?

		@ds_product.scores.delete_all

		ProductGroup.where(search_pg_str(@ds_product.name)).each do |pg|
			pg.products.each do |p|
				s = Score.new
				s.product_id = p.id
				s.ds_product_id = params[:id]
				s.pack_score = 100 * Jaccard.coefficient(@ds_product.pack_param.to_s.chars, p.pack_param.to_s.chars)
				s.country_score = 100 * Jaccard.coefficient(@ds_product.country_code.to_s.chars, p.country_name.to_s.chars)
				s.company_score = 100 * Jaccard.coefficient(@ds_product.company.to_s.chars, p.company_name.to_s.chars)
				s.save
			end
		end
		
		@ds_product = DsProduct.find(params[:id])
	 	@scores = @ds_product.scores.order("country_score desc, company_score desc, pack_score desc")
	end

	private
  
  	def product_id
  		params[:product_id]
  	end

	  def sort_column
	    DsProduct.column_names.include?(params[:sort]) ? params[:sort] : "drugstore_count"
	  end
	  
	  def sort_direction
	    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
	  end

	  def search_str
	  	params[:search].nil? ? "id is not null" : "full_name LIKE '%#{params[:search]}%'"
	  end

	  def search_pg_str(name)
	  	params[:search].nil? ? "name LIKE '#{name}%'" : "name LIKE '#{params[:search]}%'"
	  end

end
