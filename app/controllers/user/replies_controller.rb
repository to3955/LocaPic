class User::RepliesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_guest, only: [:create, :destroy]

  def create
   post = Post.find(params[:post_id])
   reply = current_user.replies.new(reply_params)
   reply.post_id = post.id
   reply.save

   @comments_count = post.replies.count
   @replies = post.replies
  end

  def destroy
   post = Post.find(params[:post_id])
   reply = post.replies.find(params[:id])

    if current_user == reply.user
      reply.destroy
    end
      @comments_count = post.replies.count
      @replies = post.replies
      @post = post  # @post変数を設定

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
