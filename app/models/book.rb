class Book < ApplicationRecord

  belongs_to :user
  #BookCommentモデルのidとの関連付け
  has_many :book_comments, dependent: :destroy
  #Favoriteモデルのidとの関連付け
  has_many :favorites, dependent: :destroy

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200, allow_blank: true}

  #引数で渡されたユーザidがFavoriteテーブル内に存在(exists?)するかどうかを調べる
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  #検索機能のプルダウンメニューの設定
  def self.search_for(content, method)
    if methdo == 'perfect'
      Book.where(title: content)
    elsif method == 'forward'
      Book.where('title LIKE ?', content+'%')
    elsif method == 'backward'
      Book.where('title LIKE ?', '%'+content)
    else
      Book.where('title LIKE ?', '%'+content+'%')
    end
  end

end
