class Restaurant < ApplicationRecord
  def full_address
    "〒" + postcode.to_s + " " + prefecture_name + address_city + address_street + address_building
  end
end
