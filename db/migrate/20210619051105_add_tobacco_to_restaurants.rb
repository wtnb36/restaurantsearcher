class AddTobaccoToRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :tobacco, :integer
  end
end
