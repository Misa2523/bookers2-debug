class FavoritesController < ApplicationController

  def create
    #URL末尾のidを持つ書籍の情報をbookに格納
    book = Book.find(params[:book_id])
    #ログインしてるユーザー情報とbook_comment_paramsで指定されたコメント情報を新規作成し、favoriteに格納
    favorite = current_user.favorites.new(book_id: book.id)
    # ↑ book_idというキーにbook.idという値を関連付けている（作成された`favorite`オブジェクトの属性`book_id`の値が、`book`オブジェクトの`id`と同じになる）
    # ↑ ハッシュと呼ばれるデータ構造

    favorite.save

    #同じページに遷移（いいねはindexページとshowページ両方で行うためこれを使う）
    redirect_to  request.referer    #リファラー
  end

  def destroy
    #URL末尾のidを持つ書籍の情報をbookに格納
    book = Book.find(params[:book_id])

    #ログインしてるユーザーが特定の本(book)をいいねしているか調べる
    #current_userのいいね(favortes)から、book_idが指定された本を検索し、見つかればfavoriteに代入
    favorite = current_user.favorites.find_by(book_id: book.id)
    #モデル名.find_by(条件)　検索でヒットしたレコードの最初１件のみを返すメソッド

    favorite.destroy
    redirect_to  request.referer
  end

end
