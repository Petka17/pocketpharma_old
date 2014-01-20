class DrugstoresController < ApplicationController

  def index
		@drugstores = Drugstore.where("name IS NOT NULL").order(:external_id).paginate(page: params[:page])
  end

  def show
		@drugstore = Drugstore.find(params[:id])
		@products = @drugstore.product_prices.paginate(page: params[:page])
  end
  
end

