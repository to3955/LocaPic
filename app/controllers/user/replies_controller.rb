class User::RepliesController < ApplicationController
  before_action :check_guest, only: [:create, :destroy]

  def create
   @post = Post.find(params[:post_id])
   @user = @post.user
   @reply = current_user.replies.new(reply_params)
   @reply.post_id = @post.id
   @reply.save
  end

  def destroy
    @reply = Reply.find(params[:id]).destroy
    @reply.destroy
    @post = Post.find(params[:post_id])
  end

  private

  def reply_params
    params.require(:reply).permit(:comment)
  end


  def check_guest
    if current_user.guest?
      # ゲストユーザーの場合、アクセスを制限
      redirect_to root_path, alert: "ゲストユーザーはこのアクションを実行できません。"
    end
  end

end
