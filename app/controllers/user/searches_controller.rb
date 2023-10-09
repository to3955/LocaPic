class User::SearchesController < ApplicationController
   before_action :authenticate_user!
  
  def index
  end
  

  def search
    @range = params[:range]
    @word = params[:word]

    if @range == "User"
      @users = User.looks(params[:search], params[:word])
    else
      @posts = Post.looks(params[:search], params[:word])
    end
  end
  
end
