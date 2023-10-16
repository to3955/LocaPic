class Admin::RepliesController < ApplicationController

  def destroy
    @reply = Reply.find(params[:id])
    post = @reply.post
    if current_user == @reply.user
      @reply.destroy
      flash[:success] = "コメントを削除しました。"
    else
      flash[:error] = "コメントの削除に失敗しました。"
    end
    redirect_to admin_post_path(post)
  end

end
