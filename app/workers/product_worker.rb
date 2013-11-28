class ProductWorker

	include Sidekiq::Worker
	# sidekiq_options queue: "high"
	sidekiq_options retry: false

  def perform
  	Product.update_db
  end
 	
end