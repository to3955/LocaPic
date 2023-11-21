class User::LikesController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:id].present?
      @user = User.find(params[:id])
    else
      @user = current_user
    end
    @liked_posts = @user.liked_posts
  end

  def create
    @user = current_user
    @post = Post.find(params[:post_id])

    # いいねがまだ存在しない場合のみ新しくいいねを作成
    unless @user.likes.exists?(post_id: @post.id)
      like = current_user.likes.new(post_id: @post.id)
      like.save
    end
    @like_counts = @post.likes.count
  end

  def destroy
    @user = current_user
    @post = Post.find(params[:post_id])

    # いいねが存在する場合のみ削除
    like = @user.likes.find_by(post_id: @post.id)
    like&.destroy

    @like_counts = @post.likes.count
  end

end
