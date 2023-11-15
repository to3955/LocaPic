class User::RelationshipsController < ApplicationController
 before_action :authenticate_user!
 before_action :check_guest, only: [:create, :destroy]


  def create
    user = User.find(params[:user_id])
    current_user.follow(user)
    @user = user
    respond_to :js
  end

  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow(user)
    @user = user
    respond_to :js
  end

  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end

  private

  def check_guest
    if current_user.guest?
      # ゲストユーザーの場合、アクセスを制限
      redirect_to root_path, alert: "ゲストユーザーはこのアクションを実行できません。"
    end
  end

end
