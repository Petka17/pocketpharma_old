class Product < ActiveRecord::Base
	
	belongs_to :product_group
	belongs_to :form
	belongs_to :dose
	belongs_to :pack
	belongs_to :inn
	belongs_to :company
	
	def self.update_db
	
		RlsProduct.all.each do |rls|
			p = Product.where(rls_code: rls.code).first_or_initialize
			
			p.ean = rls.ean
			
			t = GroupType.where(name: rls.product_type).first_or_create unless rls.product_type.empty?
			if t.nil?
				t_id = nil
			else
				t_id = t.id
			end

			p.product_group = ProductGroup.where(name: rls.name, category: rls.category, type_id: t_id).first_or_create
			
			p.form = Form.where(name: rls.product_form).first_or_create unless rls.product_form.empty? 
			p.dose = Dose.where(name: rls.dose).first_or_create unless rls.dose.empty? 
			p.pack = Pack.where(name: rls.pack).first_or_create unless rls.pack.empty? 
			
			p.inn = Inn.where(name: rls.inn).first_or_create unless rls.inn.empty? 
			
			c = Country.where(name: rls.country).first_or_create unless rls.country.empty?
			p.company = Company.where(name: rls.company, country_id: c.id).first_or_create unless rls.company.empty? || c.nil?

			p.save
		end

	end

end
