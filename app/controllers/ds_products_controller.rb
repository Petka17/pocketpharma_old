class DsProductsController < ApplicationController

	helper_method :sort_column, :sort_direction

	def index
		@ds_products = DsProduct.where(search_str).order(sort_column + " " + sort_direction + ", id asc").paginate(page: params[:page])
	end

	def show
		@ds_product = DsProduct.find(params[:id])

		unless params[:search].nil?
			@ds_product.scores.delete_all
			ProductGroup.where("name LIKE '#{params[:search]}%'").each do |pg|
				pg.products.each do |p|
					s = @ds_product.scores.build(
						product_id: p.id,
						pack_score: 100 * Jaccard.coefficient(@ds_product.pack_param.chars, p.pack_param.to_s.chars),
						country_score: 100 * Jaccard.coefficient(@ds_product.country_code.chars, p.country_name.to_s.chars),
						company_score: 100 * Jaccard.coefficient(@ds_product.company.chars, p.company_name.to_s.chars)
					)
					s.save
				end
			end
		end

	 	@scores = @ds_product.scores.order('country_score desc, company_score desc, pack_score desc')
	end

	def update_product_id
		@ds_product = DsProduct.find(params[:id])
		@ds_product.update_attribute(:product_id, params[:ds_product][:product_id])
		
		respond_to do |format|	
			format.html { render 'show' }
			format.js
		end
	end

	def accept
		@ds_product = DsProduct.find(params[:id])
		@ds_product.update_attribute(:approved_flg, !(@ds_product.approved_flg))

		respond_to do |format|	
			format.html { render 'index' }
			format.js
		end
	end

	private

	  def sort_column
	    DsProduct.column_names.include?(params[:sort]) ? params[:sort] : "drugstore_count"
	  end
	  
	  def sort_direction
	    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
	  end

	  def search_str
	  	# "name is null"
	  	# "product_id IS NOT NULL"
	  	params[:search].nil? ? "id is not null" : "full_name LIKE '%#{params[:search]}%'"
	  end

	  def search_pg_str(name)
	  	params[:search].nil? ? "name LIKE '#{name}%'" : "name LIKE '#{params[:search]}%'"
	  end

end
