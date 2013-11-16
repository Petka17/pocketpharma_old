class ProductPrice < ActiveRecord::Base
	belongs_to :drugstore
	belongs_to :ds_product

	before_save :update_ds_product

	def update_ds_product

			if self.product_id.nil?
				
				dsp = DsProduct.where(external_id: external_id).first_or_create do |d|
					d.full_name = self.full_name
					d.external_id = self.external_id
				end

				self.product_id = dsp.id

			end

	end

end
