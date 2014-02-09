class ProductGroup < ActiveRecord::Base
	has_many :products
	belongs_to :group_type, class_name: "GroupType", foreign_key: "type_id"
end