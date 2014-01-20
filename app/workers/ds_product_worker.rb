class DsProductWorker

	include Sidekiq::Worker
	sidekiq_options retry: false

  def perform(new_prod, rel, avg)

  	unless new_prod.nil?
	  	puts "Fill DsProducts table: #{DateTime.now}"
	  	i = 1
			ProductPrice.uniq.pluck(:external_id, :full_name).each do |pp|
				DsProduct.where(external_id: pp[0]).first_or_create do |d|
					d.external_id = pp[0]
					d.full_name = pp[1]
				end

				i += 1
				puts "Обработано #{i} продуктов. #{DateTime.now}"
			end
		end
		
		unless rel.nil?
			puts "Update PriceProductTable: #{DateTime.now}"

			sql = "UPDATE product_prices
						SET ds_product_id = ds_products.id            
						FROM ds_products           
						WHERE 
							ds_products.external_id = product_prices.external_id                                           
							AND 
							product_prices.ds_product_id IS NULL"

			ActiveRecord::Base.connection.execute sql

		end

		unless avg.nil?
			puts "Update average price: #{DateTime.now}"
			i = 0

			sql = "SELECT
								ds_product_id as ds_product_id,
								count(id)  as count,
								max(price) as max_price,
	              min(price) as min_price,
	              avg(price) as avg_price
	         	FROM product_prices
	         	WHERE ds_product_id IS NOT NULL AND amount > 0
	       		GROUP BY ds_product_id"

	    puts "SQL: #{sql}"

			ProductPrice.find_by_sql(sql).each do |row|

				dsp = DsProduct.find(row.ds_product_id)
				
				unless dsp.nil?
					dsp.drugstore_count = row.count
					dsp.max_price = row.max_price
					dsp.min_price = row.min_price
					dsp.avg_price = row.avg_price
					dsp.save
				end

				i += 1
				puts "Обработано #{i} продуктов"
			end
		end

		puts "Finish: #{DateTime.now}"

  end
 	
end