class AddReasonToRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :reason, :string
    add_column :restaurants, :image_id, :string
  end
end
