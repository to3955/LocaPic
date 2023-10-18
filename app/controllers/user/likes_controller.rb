class User::LikesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @liked_posts = @user.liked_posts
  end

  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    like = current_user.likes.new(post_id: @post.id)
    like.save

    @like_counts = @post.likes.count
  end

  def destroy
    @user = current_user
    @post = Post.find(params[:post_id])
    like = current_user.likes.find_by(post_id: @post.id)
    like.destroy

    @like_counts = @post.likes.count
  end



end
