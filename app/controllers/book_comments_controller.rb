class BookCommentsController < ApplicationController

  def create
    #URL末尾のidを持つ書籍の情報をbookに格納
    book = Book.find(params[:book_id])
    #ログインしてるユーザー情報とbook_comment_paramsで指定されたコメント情報を新規作成し、commentに格納
    comment = current_user.book_comments.new(book_comment_params)
    #先に定義してある書籍（book）のidを、commentのbook_idに代入
    comment.book_id = book.id

    comment.save
    redirect_to book_path(book.id)
  end

  def destroy
    #ローカル変数=BookComment.find(params[:id])
    #ローカル変数.destroy
    #の、省略記述 ↓
    BookComment.find(params[:id]).destroy
    redirect_to book_path(params[:book_id])
  end



  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
