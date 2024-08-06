class SearchesController < ApplicationController

  def search
    #選択したmodelの値を@~~にそれぞれ代入
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]

    if @model == 'user'  #modelがuserだった場合
      #Userモデルのsearch_forメソッド呼び出し
      @records = User.search_for(@content, @method)
    else   #modelがbookだった場合
      #Bookモデルのsearch_forメソッド呼び出し
      @records = Book.search_for(@content, @method)
    end
  end

end
