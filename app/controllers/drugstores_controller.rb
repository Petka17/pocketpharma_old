class DrugstoresController < ApplicationController

  def index
		@drugstores = DrugStore.where("name IS NOT NULL").order(:external_id).paginate(page: params[:page])
  end

  def show
		@drugstore = DrugStore.find(params[:id])
		@products = @drugstore.product_price.paginate(page: params[:page])
  end

	def import
		(params[:drugstore][:from]..params[:drugstore][:to]).each { |i| MedluxWorker.perform_async(i) }
		redirect_to drugstores_path
	end
	
end
