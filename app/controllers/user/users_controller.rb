class User::UsersController < ApplicationController

  def show
    @user = current_user
  end

  def edit
    @user = current_user
    if @user != current_user
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = current_user
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

  def post_params
  params.require(:post).permit(:caption, :image, :new_location_name, :new_location_description)
  end


end
