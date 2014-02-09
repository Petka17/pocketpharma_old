class ComparisionWorker

	include Sidekiq::Worker
	sidekiq_options retry: false

	def perform(count)
		i = 1

		DsProduct.where('product_id is null').order("drugstore_count desc").limit(count).each do |dsp|

			puts "#{DateTime.now} Лекарство #{dsp.id}: #{dsp.full_name}"
			puts "Имя группы: #{dsp.name}"
			puts "Количество аптек: #{dsp.drugstore_count}"
			
			dsp.scores.delete_all

			pgs = ProductGroup.where("lower(name) LIKE '#{dsp.name.downcase}%'")

			puts "Количество продуктов из эталонной базы: #{pgs.count}"

			if pgs.count < 30
				pgs.each do |pg|
					pg.products.each do |p|
						s = dsp.scores.build(
							product_id: p.id,
							pack_score: 100 * Jaccard.coefficient(dsp.pack_param.chars, p.pack_param.to_s.chars),
							country_score: 100 * Jaccard.coefficient(dsp.country_code.chars, p.country_name.to_s.chars),
							company_score: 100 * Jaccard.coefficient(dsp.company.chars, p.company_name.to_s.chars)
						)
						s.save
					end
				end
			end
 			
 			if dsp.scores.count > 0
				product_id = dsp.scores.order('country_score desc, company_score desc, pack_score desc').first.product_id
				puts "Номер продукта: #{product_id}"
				dsp.update_attribute(:product_id, product_id)
			end

			puts "Обработан продукт с номером: #{i}"

			i += 1

		end
	end

end