class DsProductWorker

	include Sidekiq::Worker
	sidekiq_options retry: false

  def perform

  # 	puts "Fill DsProducts table: #{DateTime.now}"

		# ProductPrice.uniq.pluck(:external_id, :full_name).each do |pp|
		# 	DsProduct.where(external_id: pp[0]).first_or_create do |d|
		# 		d.external_id = pp[0]
		# 		d.full_name = pp[1]
		# 	end
		# end
		
		puts "Update PriceProductTable: #{DateTime.now}"
		
		DsProduct.all.each do |dsp|
			ProductPrice.where("external_id = #{dsp.external_id}").update_all(ds_product_id: dsp.id)
		end

		puts "Update average price"

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
				dps.save
			end

		end

		puts "Finish: #{DateTime.now}"

  end
 	
end