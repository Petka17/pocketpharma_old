class ProductGroup < ActiveRecord::Base
	has_many :products
	belongs_to :group_type, class_name: "GroupType", foreign_key: "type_id"

	def self.get_similar_products(full_name)
		# Levenshtein.distance("112222", "11111")
		# Jaccard.coefficient(a, b)

		d_min = 1
		id_array = []

		self.all.each do |pg|
			d = 1 - Jaccard.coefficient(pg.name.chars, full_name.chars)

			if d_min > d
				id_array = [] 
				d_min = d
			end

			if d_min == d
				id_array.push(pg.id) 
				
				puts id_array
				puts d_min
			end
			
			
		end

		where("id IN (?)", id_array)
	end

end

# Анальгин раствор для в/в и в/м вв 500мг/мл амп 2мл ...
# Анальгин тб 500мг бл N10x2 РОС Медисорб
# Анальгин р-р д/и 50% амп 2мл N10 РОС Микроген
# Анальгин тб 500мг N10 РОС Еврофарм
# Анальгин р-р д/и 50% амп 2мл N10 АРМ Ереванская ФФ
# Анальгин-хинин тб плен/об бл N10 БОЛ Фармахим
# Анальгин тб 500мг бл N10 РОС Акрихин
# Анальгин р-р д/и 50% амп 2мл N10 РОС Белгородвитами...