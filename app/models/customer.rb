class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :wishes, dependent: :destroy
  has_many :favorite_restaurants, through: :favorites, source: :restaurant
  has_many :wish_restaurants, through: :wishes, source: :restaurant
  has_many :histories, dependent: :destroy

  enum sex: { 男性: 0, 女性: 1 }

  def full_address
    "〒" + postcode.to_s + " " + prefecture_name + address_city + address_street + address_building
  end

end
