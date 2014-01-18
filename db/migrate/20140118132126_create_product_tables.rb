class CreateProductTables < ActiveRecord::Migration
  def change
    # Reference product DB
    create_table :products do |t|
      t.integer :rls_code
      t.integer :product_group_id
      t.integer :inn_id
      t.integer :form_id
      t.integer :dose_id
      t.integer :pack_id
      t.integer :company_id
      t.integer :ean, limit: 8
      t.timestamps
    end

    add_index :products, :rls_code
    add_index :products, :product_group_id
    add_index :products, :inn_id
    add_index :products, :form_id
    add_index :products, :dose_id
    add_index :products, :pack_id
    add_index :products, :company_id
    add_index :products, :ean

    # Dose Dictionary
    create_table :doses do |t|
      t.string :name
      t.timestamps
    end
  	
  	add_index :doses, :name, unique: true

    # Form Dictionary
    create_table :forms do |t|
      t.string :name
      t.timestamps
    end

  	add_index :forms, :name, unique: true

    # Pack Dictionary
    create_table :packs do |t|
      t.string :name
      t.timestamps
    end

  	add_index :packs, 	:name, unique: true

    # INN Dictionary
    create_table :inns do |t|
      t.text :name
      t.timestamps
    end

    add_index :inns, :name, unique: true

    # Company list
    create_table :companies do |t|
      t.string :name
      t.integer :country_id
      t.timestamps
    end

    add_index :companies, [:name, :country_id], unique: true

    # Country list
    create_table :countries do |t|
      t.string :name
      t.timestamps
    end

    add_index :countries, :name, unique: true

    # Product Groups
    create_table :product_groups do |t|
      t.text 		:name
      t.string 	:category
      t.integer :type_id
      t.timestamps
    end

  	add_index :product_groups, [:name, :category, :type_id], unique: true

  	# Group Type Dictionary
    create_table :group_types do |t|
      t.text :name
      t.timestamps
    end

  	add_index :group_types, :name, unique: true
  end
end
