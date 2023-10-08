class User::PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = current_user.posts.build
    @location = Location.new # 新しい場所を入力するフォーム用
  end

  def create
  @post = current_user.posts.build(post_params)

   if params[:post][:new_location_name].present?
    # 新しい場所を作成し、緯度と経度を設定
    @location = Location.new(
      place_name: params[:post][:new_location_name],
      description: params[:post][:new_location_description],
      latitude: params[:post][:new_location_latitude],
      longitude: params[:post][:new_location_longitude]
     )

    # 投稿に新しい場所を関連付ける
     @post.location = @location
   end

   if @post.save
    redirect_to @post, notice: '投稿が作成されました'
   else
    render :new
   end
  end


  def index
    @posts = Post.all
  end

  def show
    @posts = current_user.posts
  end


  private

 def post_params
  params.require(:post).permit(:caption, :image, :location_id, :new_location_name, :new_location_description)
 end

end
