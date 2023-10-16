class ApplicationController < ActionController::Base
   before_action :configure_permitted_parameters, if: :devise_controller?
   before_action :authenticate_admin!, if: :admin_url

  def admin_url
    request.fullpath.include?("/admin")
  end

  def admin_sign_out
    # 管理者ユーザーをログアウト
    sign_out(current_user) if current_user.admin?
    # リダイレクト先を設定し、成功メッセージを表示
    redirect_to admin_session_path, notice: "管理者ユーザーとしてログアウトしました。"
  end

  def after_sign_in_path_for(resource)
    # ログイン後の遷移先を設定
    if resource == current_admin
      # 管理者ユーザーの場合、/admin/usersにリダイレクト
      admin_users_path
    else
      # 通常のユーザーの場合、通常の遷移先にリダイレクト
      users_mypage_path
    end
  end

  def after_sign_out_path_for(resource)
    if resource == :admin
      # 管理者ユーザーの場合、ログアウト後に/adminにリダイレクト
      new_admin_session_path
    else
      # 通常のユーザーの場合、ログアウト後にroot_pathにリダイレクト
    root_path
    end
  end

  def guest_sign_in
    # ゲストユーザーを作成または取得
    user = User.guest
    # ゲストユーザーとしてログイン
    sign_in user
    # リダイレクト先を設定し、成功メッセージを表示
    redirect_to root_path, notice: "ゲストユーザーとしてログインしました。"
  end

  def guest_sign_out
    # ゲストユーザーをログアウト
    sign_out(current_user) if current_user.guest?
    # リダイレクト先を設定し、成功メッセージを表示
    redirect_to root_path, notice: "ゲストユーザーとしてログアウトしました。"
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana])
  end
end
