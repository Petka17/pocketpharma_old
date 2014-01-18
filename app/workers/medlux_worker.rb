class MedluxWorker

	include Sidekiq::Worker
	sidekiq_options retry: false
	
	def perform(from, to, db)
		(from..to).each { |i| insert(i, db) }
	end

  def insert(store_id, db)
  	puts "Process Product Data for Dugstore #{store_id}: #{DateTime.now}"

		url = "http://medlux.ru/?store=#{store_id}&drugs=all"
		page = Nokogiri::HTML(open(url), nil, 'UTF-8')

		drugstore_data 	= page.css('table.store_data')
		product_data 		= page.css('table.other_drugs tr')
		drugstore_name 	= page.css('div.store_name_div a')[0] || page.css('div.store_name_div_nonsprav a')[0]

		drugstore = Drugstore.where(external_id: store_id).first_or_initialize

		drugstore.external_id = store_id

		unless drugstore_name.nil?
			drugstore.name 							= drugstore_name.content
			drugstore.address 					= drugstore_data.css('tr')[0].css('td')[1].content
			drugstore.phone 						= drugstore_data.css('tr')[2].css('td')[1].content
			drugstore.working_hours 		= drugstore_data.css('tr')[3].css('td')[1].content
			date_string 								= drugstore_data.css('tr')[4].css('td')[1].content
			drugstore.data_last_update 	= date_string[0, 6] + "20" + date_string[6, 8]
		end

		drugstore.save
		
		if db.nil?
			ProductPrice.where(drugstore_id: drugstore.id).update_all(amount: 0)
		else
			ProductPrice.where(drugstore_id: drugstore.id).delete_all
		end

		unless product_data.size.zero?
			product_data.shift

			inserts = []

			product_data.each do |r|

				row = r.css('td')

				external_id = row.css('a')[0]['href'].gsub(/\D/, '')
				full_name 	= row[0].content
				price 			= row[row.size-2].content.gsub(/[ руб.]/, '').gsub(/[,]/, '.')
				amount 			= row[row.size-1].content.gsub(/[уп.]/, '')
		
				if db.nil?
					product_price = drugstore.product_price.where(external_id: external_id).first_or_initialize

					product_price.external_id = external_id
					product_price.full_name 	= full_name
					product_price.price 			= price
					product_price.amount 			= amount

					product_price.save
				else
					inserts.push "(#{drugstore.id},#{external_id},\'#{full_name}\',#{price},#{amount})"
				end

			end
    	
    	unless db.nil?
	    	sql = "INSERT INTO product_prices (drugstore_id, external_id, full_name, price, amount) VALUES #{inserts.join(", ")}"
				ActiveRecord::Base.connection.execute sql
			end

		end

		drugstore.product_num = drugstore.product_price.count
		drugstore.save
		
	end

end