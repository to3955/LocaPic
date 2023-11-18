class User::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:update]
  before_action :check_guest, only: [:new, :create, :destroy]

  def new
    @post = current_user.posts.build
    @location = Location.new # 新しい場所を入力するフォーム用
  end

  def create
    if params[:post].present? && (params[:post][:new_location_name].blank? && params[:post][:location_id].blank?)
      flash[:alert] = '新しい場所を入力するか、既存の場所を選択してください.'
      redirect_to new_post_path
    else
      # フォームデータから新しいロケーションを作成または既存のロケーションを取得
      if params[:post][:new_location_name].present?
        @location = Location.new(
          place_name: params[:post][:new_location_name],
          description: params[:post][:new_location_description],
          latitude: params[:post][:latitude],
          longitude: params[:post][:longitude]
        )
        if @location.save
          # ロケーションが正常に保存された場合の処理
        else
          # ロケーションの保存に失敗した場合の処理
          render :new
          return
        end
      else
        @location = Location.find_by(id: params[:post][:location_id])
      end

      # ロケーションが正常に取得または作成された場合、ポストを作成
      if @location
        @post = Post.new(post_params)
        @post.location = @location
        @post.user = current_user

        if @post.save
          # ポストの保存に成功した場合の処理
          redirect_to show_detail_post_path(@post), notice: '投稿が作成されました'
        else
          # ポストの保存に失敗した場合の処理
          flash.now[:alert] = '投稿の作成に失敗しました。入力内容を確認してください。'
          render :new
        end
      else
        # ロケーションが取得または作成できなかった場合の処理
        render :new
      end
    end
  end



  def index
    @post = Post.new

    if params[:show_all_posts] == 'true'
      # フォローしているユーザーがいなくても全ての投稿を取得
      @posts = Post.all
    else
      # フォローしているユーザーのIDを取得
      followings_user_ids = current_user.followings.pluck(:id)

      if followings_user_ids.present?
        # フォローしているユーザーの投稿一覧を取得
        @posts = Post.where(user_id: followings_user_ids)
      else
        # フォローしているユーザーがいない場合は空の配列
        @posts = []
      end
    end

    # 全ての投稿を取得
    @all_posts = Post.all

    @like_counts = {}
    @comment_counts = {}

    @posts.each do |post|
      @like_counts[post.id] = post.likes.count
      @comment_counts[post.id] = post.replies.count
    end

    # 全ての投稿に関連するいいねとコメント数も取得
    @all_posts.each do |post|
      @like_counts[post.id] = post.likes.count
      @comment_counts[post.id] = post.replies.count
    end
  end


  def show
    if params[:id].present?
      @user = User.find(params[:id])
    else
      @user = current_user
    end

    @posts = @user.posts
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

     # 地図表示のために緯度と経度をビューに渡す
    @latitude = @post.location&.latitude
    @longitude = @post.location&.longitude
  end


  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to users_posts_path(current_user)
  end



  private

 def post_params
  params.require(:post).permit(:image, :caption, :new_location_name, :new_location_description)
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