class RelationshipsController < ApplicationController

  before_action :authenticate_user!

  def create
    #フォロー対象のユーザーを特定
    user = User.find(params[:user_id])
    #ログインしてるユーザーがその↑ユーザーをフォロー
    current_user.follow(user)
    redirect_to request.referer
  end

  def destroy
    #フォロー解除対象のユーザーを特定
    user = User.find(params[:user_id])
    #ログインしてるユーザーがその↑ユーザーのフォローを解除
    current_user.unfollow(user)
    redirect_to request.referer
  end

  #特定のユーザーがフォローしているユーザーの一覧を表示するためのアクション
  def followings
    #対象のユーザーを特定
    user = User.find(params[:user_id])
    #そのユーザー(user)がフォローしているユーザー（user.followings）を@usersに代入
    @users = user.followings
  end

  #特定のユーザーをフォローしているユーザーの一覧を表示するためのアクション
  def followers
    #対象のユーザーを特定
    user = User.find(params[:user_id])
    #そのユーザー(user)をフォローしているユーザー（user.followiers）を@usersに代入
    @users = user.followers
  end

end
