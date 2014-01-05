class GroupType < ActiveRecord::Base
	has_many :product_groups, :class_name => "ProductGroup", :foreign_key => "type_id"
end
