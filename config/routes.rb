Rails.application.routes.draw do

  # deviseというgemを使ったユーザー認証機能を実装するためのルーティングを設定
  # devise_for :usersは、devise gemを使用してユーザー認証機能を追加するためのルーティング設定
  #m無限ループ回避のため、下記のresources :usersよりも前に記述しなくてはいけない！
  devise_for :users

  root to: 'homes#top'
  get 'home/about', to: "homes#about"  #get 'home/about' => 'homes#about', as: 'about'

  #いいね、コメントはそれぞれ書籍に対しされるため、favoriteとbook_commentsはbooksに結び付く（親子関係）
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    #いいね機能のみresourceで単数形→/:idがURLに含まれなくなる
    #1投稿に対しいいねは1回のみ → destroyの時ユーザーidとbookのidが分かればどのいいねをけせばいいか分かる
      # → いいねのidはURLに含める必要がない（params[:id]を使わなくていい）ため、resourceという単数形
    resource :favorite, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :users, only: [:index,:show,:edit,:update]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end