class DsProductWorker

	include Sidekiq::Worker
	# sidekiq_options queue: "high"
	sidekiq_options retry: false

  def perform
  	ProductPrice.where(product_id: nil).each do |pp|
			pp.save
		end
  end
 	
end