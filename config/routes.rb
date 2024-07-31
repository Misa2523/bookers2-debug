Rails.application.routes.draw do

  # deviseというgemを使ったユーザー認証機能を実装するためのルーティングを設定
  # devise_for :usersは、devise gemを使用してユーザー認証機能を追加するためのルーティング設定
  #そのため、下記のresources :usersよりも前に記述しなくてはいけない！
  devise_for :users

  root to: 'homes#top'
  get 'home/about', to: "homes#about"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update]
  resources :users, only: [:index,:show,:edit,:update]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end