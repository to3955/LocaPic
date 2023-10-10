class User::RepliesController < ApplicationController

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

end
