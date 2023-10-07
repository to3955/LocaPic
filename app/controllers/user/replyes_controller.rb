class User::ReplyesController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    comment = current_user.posts.new(reply_params)
    comment.post_id = post.id
    comment.save
    redirect_to post_path(post)
  end

  def destroy
  end
  
  private

  def reply_params
    params.require(:reply).permit(:comment)
  end
  
end
