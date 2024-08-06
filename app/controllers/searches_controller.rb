class SearchesController < ApplicationController

  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]

    if @model = 'user'  #modelがuserだった場合
      @records = User.search_for(@content, @method)
    else   #modelがbookだった場合
      @records = Book.search_for(@content, @method)
    end
  end

end
