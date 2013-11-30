class MedluxWorker

	include Sidekiq::Worker
	# sidekiq_options queue: "high"
	sidekiq_options retry: false
	
	def perform(from, to)
		(from..to).each { |i| db_insert(i)}
	end

  def db_insert(store_id)
  	puts "Process Product Data for Dugstore #{store_id}: #{DateTime.now}"

		url = "http://medlux.ru/dsearch01/store_info.php?store=#{store_id}&show_list=yes"
		page = Nokogiri::HTML(open(url), nil, 'KOI8-R')

		drug_store_data = page.css('table.store_data')
		product_data = page.css('table.other_drugs tr')

		drugstore_name = page.css('div.store_name_div a')[0] || page.css('div.store_name_div_nonsprav a')[0]

		drug_store = DrugStore.where(external_id: store_id).first_or_initialize
		drug_store.external_id = store_id

		unless drugstore_name.nil?
			drug_store.name 						= drugstore_name.content
			drug_store.address 					= drug_store_data.css('tr')[0].css('td')[1].content
			drug_store.phone 						= drug_store_data.css('tr')[2].css('td')[1].content
			drug_store.working_hours 		= drug_store_data.css('tr')[3].css('td')[1].content
			date_string 								= drug_store_data.css('tr')[4].css('td')[1].content
			drug_store.data_last_update = date_string[0, 6] + "20" + date_string[6, 8]
		end

		drug_store.save
		
		ProductPrice.where(drugstore_id: drug_store.id).delete_all

		unless product_data.size.zero?
			product_data.shift

			inserts = []

			product_data.each do |r|

				row = r.css('td')

				product_id  = row.css('a')[0]['href'].gsub(/\D/, '')
				full_name 	= row[0].content
				price 			= row[row.size-2].content.gsub(/[ руб.]/, '').gsub(/[,]/, '.')
				amount 			= row[row.size-1].content.gsub(/[уп.]/, '')
		
		    inserts.push "(#{drug_store.id},#{product_id},\'#{full_name}\',#{price},#{amount})"
			end
    	
    	sql = "INSERT INTO product_prices (drugstore_id, external_id, full_name, price, amount) VALUES #{inserts.join(", ")}"
			ActiveRecord::Base.connection.execute sql

		end
	end

# ------------------------
# ------------------------
# ------------------------

	def model_insert(store_id)
		url = "http://medlux.ru/dsearch01/store_info.php?store=#{store_id}&show_list=yes"
		page = Nokogiri::HTML(open(url), nil, 'KOI8-R')

		drug_store_data = page.css('table.store_data')
		product_data = page.css('table.other_drugs tr')

		drugstore_name = page.css('div.store_name_div a')[0] || page.css('div.store_name_div_nonsprav a')[0]

		drug_store = DrugStore.where(external_id: store_id).first_or_initialize
		drug_store.external_id = store_id

		unless drugstore_name.nil?
			drug_store.name 						= drugstore_name.content
			drug_store.address 					= drug_store_data.css('tr')[0].css('td')[1].content
			drug_store.phone 						= drug_store_data.css('tr')[2].css('td')[1].content
			drug_store.working_hours 		= drug_store_data.css('tr')[3].css('td')[1].content
			date_string 								= drug_store_data.css('tr')[4].css('td')[1].content
			drug_store.data_last_update = date_string[0, 6] + "20" + date_string[6, 8]
		end

		drug_store.save
		
		drug_store.product_price.update_all(delete_flag: true)

		unless product_data.nil?
			product_data.shift

			product_data.each do |r|
				
				row = r.css('td')

				product_id = row.css('a')[0]['href'].gsub(/\D/, '')

				product_price = drug_store.product_price.where(external_id: product_id).first_or_initialize

				product_price.external_id = product_id
				product_price.full_name 	= row[0].content
				product_price.price 			= row[row.size-2].content.gsub(/[ руб.]/, '').gsub(/[,]/, '.')
				product_price.amount 			= row[row.size-1].content.gsub(/[уп.]/, '')
				product_price.delete_flag = false

				product_price.save
			end
			
		end

	end  	
end