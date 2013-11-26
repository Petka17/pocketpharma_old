class ChangeInnColumnLengthForTableRlsProduct < ActiveRecord::Migration
	def up
	    change_column :rls_products, :inn, :text
	end
	def down
	    change_column :rls_products, :inn, :string
	end
end
