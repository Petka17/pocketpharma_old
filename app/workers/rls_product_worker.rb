class RlsProductWorker

	include Sidekiq::Worker
	# sidekiq_options queue: "high"
	sidekiq_options retry: false

  def perform(file)
  	RlsProduct.import(file)
  end
 	
end