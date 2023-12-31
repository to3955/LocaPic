class User::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_guest, only: [:show]

  def show
    if params[:id].present?
       @user = User.find(params[:id])
       @post = Post.find_by(user: @user, id: params[:post_id])
    else
       @user = current_user
       @post = Post.find_by(user: @user, id: params[:post_id])
    end
  end



  def follows
    @user = User.find(params[:id])
    @users = @user.followings
    render 'user/relationships/followings'
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers # フォロワーのリストを取得
    render 'user/relationships/followings'
  end

  def edit
    @user = current_user
    if @user != current_user
      redirect_to user_path(current_user.id)
    end
  end


  def update
    @user = current_user

    if params[:user][:profile_image].present?
      # 新しいプロフィール画像が送信された場合
      @user.profile_image.purge  # 既存の画像を削除（任意）
      @user.profile_image.attach(params[:user][:profile_image])  # 新しい画像をアタッチ
    end

    if @user.update(user_params)
      redirect_to users_mypage_path
    else
      render "edit"
    end
  end


  def confirm
  end

  def out
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end


  private

  def post_params
  params.require(:post).permit(:caption, :image, :new_location_name, :new_location_description)
  end

  def user_params
  params.require(:user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :is_deleted)  # 必要な属性を適切に設定
  end

  def check_guest
    if current_user.guest?
      # ゲストユーザーの場合、アクセスを制限
      redirect_to root_path, alert: "ゲストユーザーはこのアクションを実行できません。"
    end
  end

end
