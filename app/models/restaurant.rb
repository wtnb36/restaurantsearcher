class Restaurant < ApplicationRecord
  has_many :reviews, dependent: :destroy

  def full_address
    "〒" + postcode.to_s + " " + prefecture_name + address_city + address_street + address_building
  end
  
  #reviewsscore平均値
  def review_score_ave
    unless self.reviews.empty?
      reviews.average(:score).round(1).to_f
    else
      0.0
    end
  end
  
  #reviewsscore百分率
  def review_score_pct
    unless self.reviews.empty?
      reviews.average(:score).round(1).to_f*100/5
    else
      0.0
    end
  end
end
