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

  #検索条件に応じてデータベースから該当する書籍を取得
  def self.search_for(content, method)  #selfをつけると、Userクラス自体のsearch_forメソッドを定義
    if method == 'perfect'
      #モデルクラス.where(カラム名: 値)　完全一致
      Book.where(title: content)
    elsif method == 'forward'
      #モデルクラス.where('カラム名 LIKE?', 値+'%')  前方一致
      Book.where('title LIKE ?', content+'%')
    elsif method == 'backward'
                                #'%'+値　後方位置
      Book.where('title LIKE ?', '%'+content)
    else
                                #'%'+値+'%')  値(文字列)を含む
      Book.where('title LIKE ?', '%'+content+'%')
    end
  end

end
