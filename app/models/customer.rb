class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :last_name, :first_name, :last_name_kana, :first_name_kana,
            :nickname, :sex, :birth_date, :postcode, :prefecture_code,
            :address_city, :address_street, :phone_number, presence:true

  validates :last_name_kana, :first_name_kana,
            format: {
              with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/,
            }

  validates :postcode, :phone_number, numericality: { only_integer: true}

  validates :nickname, :email, uniqueness: true


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

  def self.looks(searches, words)
    if searches == "perfect_match"
      @customer = Customer.where("nickname LIKE ?", "#{words}")
    else
      @customer = Customer.where("nickname LIKE ?", "%#{words}%")
    end
  end

end
