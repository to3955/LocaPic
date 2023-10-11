class Admin::PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id]) # 投稿の情報を取得
    @user = @post.user if @post.user # 投稿者の情報を取得
    @replies = @post.replies
  end

  def destroy
    @post = Post.find(params[:id])
    @user = @post.user

    # 不適切な投稿を削除
    @post.destroy

    # 削除したことを投稿者に通知（例: メッセージを送信）
    message = "あなたの投稿が削除されました。理由: [理由をここに記入]"
    # メッセージを作成し、投稿者に送信
    @user.send_message("システムからのお知らせ", message, "システム")

    redirect_to admin_posts_path, notice: '投稿が削除されました'
  end
end
