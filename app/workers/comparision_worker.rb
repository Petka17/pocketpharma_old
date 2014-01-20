class ComparisionWorker

	include Sidekiq::Worker
	sidekiq_options retry: false

	def perform
		# DsProduct.all.each 

		DsProduct.all.order('drugstore_count DESC').limit(30).each do |dsp|
			dsp.scores.delete_all
			get_similar_products(dsp.full_name, dsp.id)
		end

	end

	def get_similar_products(full_name, dsp_id)

		puts "#{DateTime.now}	Drugstore product name: #{full_name}"

		d_max = 0
		id_array = []

		ProductGroup.all.each do |pg|

			al_fullname = AlgorithmString.new(full_name.downcase)
			
			name = pg.alias.nil? ? pg.name : pg.alias

			d = al_fullname.longest_common_substring(name.downcase).length

			if d_max < d
				id_array = [] 
				d_max = d
			end

			id_array.push(pg.id) if d_max == d && d_max > 0

		end

		puts "#{DateTime.now}	Ids Array: #{id_array}"

		ProductGroup.where("id IN (?)", id_array).each do |pg|
			pg.products.each do |p|
				s = Score.new
				s.product_id = p.id
				s.ds_product_id = dsp_id
				s.save				
			end

		end

	end
end