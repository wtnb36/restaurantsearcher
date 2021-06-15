class CreateWishes < ActiveRecord::Migration[5.2]
  def change
    create_table :wishes do |t|
      t.references  :customer, null: false, foreign_key: true
      t.references  :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
