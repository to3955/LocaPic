class User::SearchesController < ApplicationController

  def index
    @search_history = current_user.search_histories.order(created_at: :desc)
  end

  def search
    @range = params[:range]
    @word = params[:word]

    if @range == "User"
      @users = User.looks(params[:search], params[:word])
    else
      @posts = Post.looks(params[:search], params[:word])
    end
      current_user.search_histories.create(query: @word)
  end

end
