class Favorite < ApplicationRecord

  #Userモデルのidとの関連付け
  belongs_to :user
  #bookモデルのidとの関連付け
  belongs_to :book
  
  #同じ人が同じ投稿に複数回いいねできないよう制限
  # uniquenessの指定でvalidatesメソッドの引数user_idカラムの値がすでにテーブルに保存されている値と重複してないかをチェック
  # scopeの指定で、user_idとbook_idのペアに対し既に同じ値のペアがテーブルに保存されてないか
  validates :user_id, uniqueness: {scope: :book_id}

end
