class DrugstoresController < ApplicationController

  def index
		@drugstores = DrugStore.where("name IS NOT NULL").order(:external_id).paginate(page: params[:page])
  end

  def show
		@drugstore = DrugStore.find(params[:id])
		@products = @drugstore.product_price.paginate(page: params[:page])
  end

	def import
	 	MedluxWorker.perform_async(params[:drugstore][:from], params[:drugstore][:to])
		redirect_to drugstores_path
	end

end

