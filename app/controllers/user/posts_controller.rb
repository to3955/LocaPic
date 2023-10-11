class User::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:update]
  before_action :check_guest, only: [:new, :create, :destroy]

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
      longitude: params[:post][:new_location_longitude],
      post_id: @post.id
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
    @post = Post.new

    @like_counts = {}
    @posts.each do |post|
    @like_counts[post.id] = post.likes.count
    end
 # 各投稿のコメント数（Replyの数）を取得
    @comment_counts = {}
    @posts.each do |post|
    @comment_counts[post.id] = post.replies.count
    end
  end

  def show
    @posts = current_user.posts
  end

  def show_detail
    @post = Post.find(params[:id])
    @reply = Reply.new

    # 特定の投稿のいいねの数を取得
    @like_counts = {}
    @like_counts[@post.id] = @post.likes.count

    # 特定の投稿のコメント数（Replyの数）を取得
    @comment_counts = {}
    @comment_counts[@post.id] = @post.replies.count
  end


  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_posts_path(current_user)
  end



  private

 def post_params
  params.require(:post).permit(:caption, :image, :location_id, :new_location_name, :new_location_description)
 end

 def is_matching_login_user
  post = Post.find(params[:id])
  unless post.user_id == current_user.id
    redirect_to post_path
  end
 end

 def check_guest
    if current_user.guest?
      # ゲストユーザーの場合、アクセスを制限
      redirect_to root_path, alert: "ゲストユーザーはこのアクションを実行できません。"
    end
 end

end
