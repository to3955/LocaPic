class Admin::RepliesController < ApplicationController
  before_action :authenticate_admin! # 管理者アカウントの認証が必要

  def destroy
    @reply = Reply.find(params[:id])
    post = @reply.post

    if @reply.destroy
      flash[:success] = "コメントを削除しました。"
    else
      flash[:error] = "コメントの削除に失敗しました。"
    end

    redirect_to admin_post_path(post)
  end
end
