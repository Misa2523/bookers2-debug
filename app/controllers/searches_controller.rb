class SearchesController < ApplicationController

  def search
    #選択したmodelの値を@~~にそれぞれ代入
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]

    if @model == 'user'  #modelがuserだった場合
      @records = User.search_for(@content, @method)
    else   #modelがbookだった場合
      @records = Book.search_for(@content, @method)
    end
  end

end
