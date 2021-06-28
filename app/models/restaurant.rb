class Restaurant < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :wishes, dependent: :destroy
  has_many :histories, dependent: :destroy

  validates :name, :postcode, :prefecture_code, :address_city,
            :address_street, :phone_number, presence: true

  # 店名、市区町村以降の住所,電話番号が同一のものは作れない
  validates :name, uniqueness: { scope: %i[address_street phone_number] }

  def full_address
    '〒' + postcode.to_s + ' ' + prefecture_name + address_city + address_street + address_building
  end

  # reviewsscore平均値
  def review_score_ave
    if reviews.empty?
      0.0
    else
      reviews.average(:score).round(1).to_f
    end
  end

  # reviewsscore百分率
  def review_score_pct
    if reviews.empty?
      0.0
    else
      reviews.average(:score).round(1).to_f * 100 / 5
    end
  end

  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end

  def wished_by?(customer)
    wishes.where(customer_id: customer.id).exists?
  end

  enum tobacco: { 喫煙可: 0, 禁煙: 1, 不明: 2 }

  attachment :image

  def self.looks(searches, words)
    @restaurant = if searches == 'perfect_match'
                    Restaurant.where('name LIKE ?', words.to_s)
                  else
                    Restaurant.where('name LIKE ?', "%#{words}%")
                  end
  end
end
