class AddIntroductionToRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :introduction, :text
  end
end
