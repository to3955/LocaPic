class User::SearchesController < ApplicationController

  def index
  end


 def search
   exit
   @range = params[:range]
   @word = params[:word]

   if @range == "User"
      @users = User.looks(params[:search], params[:word])
   else
      @posts = Post.looks(params[:search], params[:word])
   end


 end

end
