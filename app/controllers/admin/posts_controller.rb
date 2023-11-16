class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @posts = Post.all
  end

  def user_posts
      @user = User.find(params[:id])
      @posts = @user.posts
      render 'index' # index のビューを再利用する
  end

  def show
    @post = Post.find(params[:id]) # 投稿の情報を取得
    @user = @post.user if @post.user # 投稿者の情報を取得
    @replies = @post.replies
    @likes = @post.likes
  end


  def destroy
    @post = Post.find(params[:id])

    # 不適切な投稿を削除
    @post.destroy

    redirect_to admin_posts_path, notice: '投稿が削除されました'
  end

end

