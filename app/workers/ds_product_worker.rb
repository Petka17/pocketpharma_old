class DsProductWorker

	include Sidekiq::Worker
	# sidekiq_options queue: "high"
	sidekiq_options retry: false

  def perform

  	puts "Fill DsProducts table: #{DateTime.now}"

		ProductPrice.uniq.pluck(:external_id, :full_name).each do |pp|
			DsProduct.where(external_id: pp[0]).first_or_create do |d|
				d.external_id = pp[0]
				d.full_name = pp[1]
			end
		end
		
		puts "Update PriceProductTable: #{DateTime.now}"
			
		i=1
		DsProduct.all.each do |dsp|
			print "#{i} #{dsp.external_id}|"
			ProductPrice.where("external_id = #{dsp.external_id} and product_id IS NULL").update_all(product_id: dsp.id)
			i+=1
		end

		puts "Finish: #{DateTime.now}"

  end
 	
end