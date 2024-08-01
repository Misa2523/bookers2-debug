class Book < ApplicationRecord
  belongs_to :user
  #Favoriteモデルのidとの関連付け
  has_many :favorites, dependent: :destroy

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200, allow_blank: true}

  #引数で渡されたユーザidがFavoriteテーブル内に存在(exists?)するかどうかを調べる
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end
