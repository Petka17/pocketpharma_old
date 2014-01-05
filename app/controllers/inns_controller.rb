class InnsController < ApplicationController
	
	def index
		@inns = Inn.paginate(page: params[:page])
	end

	def show
		@inn = Inn.find(params[:id])
		@products = @inn.products.paginate(page: params[:page])
	end

end
