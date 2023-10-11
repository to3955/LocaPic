class Admin::RepliesController < ApplicationController

  def destroy
    @reply = Reply.find(params[:id])
    if current_user == @reply.user
      @reply.destroy
      redirect_to admin_post_path(@reply.post), notice: "リプライを削除しました。"
    else
      redirect_to admin_post_path(@reply.post), alert: "リプライを削除できませんでした。"
    end
  end

end
