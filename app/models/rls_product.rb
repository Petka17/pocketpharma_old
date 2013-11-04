class RlsProduct < ActiveRecord::Base

	def self.import(file)

	  spreadsheet = Roo::Excel.new(file.path, nil, :ignore)

	  header = spreadsheet.row(1)

	  (2..spreadsheet.last_row).each do |i|
	    
	    row = Hash[[header, spreadsheet.row(i)].transpose]
	    
	    product = RlsProduct.find_by_code(row["code"]) || new

	    product.code 				 = row["code"]
			product.name 				 = row["name"]
			product.category 		 = row["category"]
			product.product_type = row["type"]
			product.product_form = row["form"]
			product.dose 				 = row["dose"]
			product.pack 				 = row["pack"]
			product.company 		 = row["company"]
			product.country 		 = row["country"]
			product.inn 				 = row["inn"]
			product.ean 				 = row["ean"]

	    product.save!

	  end

	end

end
