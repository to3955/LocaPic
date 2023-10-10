class User::LikesController < ApplicationController
  before_action :authenticate_user!

  def index
    @liked_posts = current_user.likes.map(&:post)
  end

  def create
    @post = Post.find(params[:post_id])
    like = current_user.likes.new(post_id: @post.id)
    like.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    like = current_user.likes.find_by(post_id: @post.id)
    like.destroy
  end

end
