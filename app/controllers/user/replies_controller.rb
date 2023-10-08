class User::ReplyesController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    comment = current_user.posts.new(reply_params)
    comment.post_id = post.id
    comment.save
    redirect_to post_path(post)
  end

  def destroy
     reply = Reply.find(params[:id])
    post = reply.post # コメントが属する投稿を取得
    if reply.user == current_user
      reply.destroy
      redirect_to post_path(post), notice: 'コメントが削除されました'
    else
      redirect_to post_path(post), alert: 'コメントを削除する権限がありません'
    end
  end
  
  private

  def reply_params
    params.require(:reply).permit(:comment)
  end
  
end
