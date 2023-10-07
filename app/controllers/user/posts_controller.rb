class User::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    # 新しい場所を作成し、緯度と経度を設定
    new_location = Location.create(
      place_name: params[:post][:new_location_name],
      description: params[:post][:new_location_description], # :description に変更
      latitude: params[:post][:new_location_latitude],
      longitude: params[:post][:new_location_longitude]
    )

    # 新しい場所を投稿に関連付ける
    @post.location = new_location

    if @post.save
      redirect_to @post, notice: '投稿が作成されました'
    else
      render :new
    end
  end

  def index
    @post = Post.all
  end

  def show
  end

  private

  def post_params
    params.require(:post).permit(:caption, :image) # 必要な属性を許可
  end
end
