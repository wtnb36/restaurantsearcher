class CreateHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :histories do |t|
      t.references  :customer, null: false, foreign_key: true
      t.references  :restaurant, null: false, foreign_key: true
      t.date :date

      t.timestamps
    end
  end
end
