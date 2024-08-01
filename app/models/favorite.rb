class Favorite < ApplicationRecord

  #Userモデルのidとの関連付け
  belongs_to :user
  #bookモデルのidとの関連付け
  belongs_to :book

end
