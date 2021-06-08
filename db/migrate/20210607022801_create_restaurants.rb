class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|

      t.string :name
      t.integer :postcode
      t.integer :prefecture_code
      t.string :address_city
      t.string :address_street
      t.string :address_building
      t.string :phone_number
      t.string :business_hours
      t.string :holiday
      t.boolean :is_deleted, default: false, null: false
      t.timestamps
    end
  end
end
