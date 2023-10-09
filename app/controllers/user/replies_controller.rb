class User::RepliesController < ApplicationController

  def create
   post = Post.find(params[:post_id])
   comment = current_user.replies.new(reply_params)
   comment.post_id = post.id
   if comment.save
     # コメントの作成が成功した場合、JavaScriptやJSONを返す
     render json: { comment: comment, notice: 'コメントが作成されました' }
   else
    # コメントの作成に失敗した場合、エラーメッセージを含むJavaScriptやJSONを返す
     render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
   end
  end

  def destroy
    reply = Reply.find(params[:id])
    post = reply.post
   if reply.user == current_user
      reply.destroy
     # コメントの削除が成功した場合、JavaScriptやJSONを返す
      render json: { notice: 'コメントが削除されました' }
   else
     # コメントの削除に失敗した場合、エラーメッセージを含むJavaScriptやJSONを返す
      render json: { errors: 'コメントを削除する権限がありません' }, status: :unprocessable_entity
   end
  end


  private

  def reply_params
    params.require(:reply).permit(:comment)
  end

end
