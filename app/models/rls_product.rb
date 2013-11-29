class RlsProduct < ActiveRecord::Base

	def self.mass_insert(file)

	  spreadsheet = Roo::Excel.new(file.path, nil, :ignore)

	  header = spreadsheet.row(1)

		inserts = []

	  (2..spreadsheet.last_row).each do |i|	    
	    row = Hash[[header, spreadsheet.row(i)].transpose]
	    
	    inserts.push "(#{row["code"]},\'#{row["name"]}\',\'#{row["category"]}\',\'#{row["type"]}\',\'#{row["form"]}\',\'#{row["dose"]}\',\'#{row["pack"]}\',\'#{row["company"]}\',\'#{row["country"]}\',\'#{row["inn"]}\',\'#{row["ean"]}\')"
	  end

		sql = "INSERT INTO rls_products (code, name, category, product_type, product_form, dose, pack, company, country, inn, ean) VALUES #{inserts.join(", ")}"

    ActiveRecord::Base.connection.execute sql
		
	end

end
