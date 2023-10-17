class User::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:update]
  before_action :check_guest, only: [:new, :create, :destroy]

  def new
    @post = current_user.posts.build
    @location = Location.new # 新しい場所を入力するフォーム用
  end

  def create
    if params[:post][:new_location_name].present?
      @location = Location.new(
        place_name: params[:post][:new_location_name],
        description: params[:post][:new_location_description],
        latitude: params[:post][:new_location_latitude],
        longitude: params[:post][:new_location_longitude]
      )

      if @location.save
        @post = current_user.posts.build(
          caption: params[:post][:caption],
          location: @location
        )

        if @post.save
          redirect_to show_detail_post_path(@post), notice: '投稿が作成されました'
        else
          render :new
        end
      else
        render :new
      end
    else
      @post = current_user.posts.build(post_params)

      if @post.save
        redirect_to show_detail_post_path(@post), notice: '投稿が作成されました'
      else
        render :new
      end
    end
  end


  def index
    @post = Post.new

    # フォローしているユーザーのIDを取得
   followings_user_ids = current_user.followings.pluck(:id)

    # フォローしているユーザーの投稿一覧を取得
    @posts = Post.where(user_id: followings_user_ids)

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
    @like_counts = {}
    @comment_counts = {}
    @replies = {}

    @posts.each do |post|
    @like_counts[post.id] = post.likes.count
    @comment_counts[post.id] = post.replies.count
    @replies[post.id] = post.replies
    end
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
     # 特定の投稿に関連するコメントを取得
     @replies = @post.replies
  end


  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_posts_path(current_user)
  end



  private

 def post_params
  params.require(:post).permit(:image, :caption, :new_location_name, :new_location_description, :new_location_latitude, :new_location_longitude)
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
