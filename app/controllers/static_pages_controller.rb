class StaticPagesController < ApplicationController

	def home
	end

	def manage
	end

	def rls_import
  	# RlsProductWorker.perform_async(params[:file].path)
  	import_rls_product(params[:file].path)
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
	
	private
	  def import_rls_product(path)
		  spreadsheet = Roo::Excel.new(path, nil, :ignore)
		  header = spreadsheet.row(1)
			inserts = []

		  (2..spreadsheet.last_row).each do |i|	    
		    row = Hash[[header, spreadsheet.row(i)].transpose]
		    ean = row["ean"].to_s.empty? ? "NULL" : row["ean"].to_i
		    inserts.push "(#{row["code"]},\'#{row["name"]}\',\'#{row["category"]}\',\'#{row["type"]}\',\'#{row["form"]}\',\'#{row["dose"]}\',\'#{row["pack"]}\',\'#{row["company"]}\',\'#{row["country"]}\',\'#{row["inn"]}\',#{ean})"
		  end

			sql = "INSERT INTO rls_products (code, name, category, product_group_type, product_form, dose, pack, company, country, inn, ean) VALUES #{inserts.join(", ")}"

	    ActiveRecord::Base.connection.execute sql
		end
end