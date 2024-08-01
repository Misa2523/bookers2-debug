Rails.application.routes.draw do

  # deviseというgemを使ったユーザー認証機能を実装するためのルーティングを設定
  # devise_for :usersは、devise gemを使用してユーザー認証機能を追加するためのルーティング設定
  #m無限ループ回避のため、下記のresources :usersよりも前に記述しなくてはいけない！
  devise_for :users

  root to: 'homes#top'
  get 'home/about', to: "homes#about"  #get 'home/about' => 'homes#about', as: 'about'

  #コメントは書籍に対しされるため、book_commentsはbooksに結び付く（親子関係）
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :book_comments, only: [:create]
  end

  resources :users, only: [:index,:show,:edit,:update]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end