class StaticPagesController < ApplicationController

	def home
	end

	def manage
	end

	def rls_import
  	RlsProductWorker.perform_async(params[:file].path)
		redirect_to manage_path
	end

	def rls_normalize
  	ProductWorker.perform_async
		redirect_to manage_path
	end

	def medlux_import
		MedluxWorker.perform_async(params[:from], params[:to], params[:db])
		redirect_to manage_path
	end

	def dsp_update
		DsProductWorker.perform_async
		redirect_to manage_path		
	end
	
end