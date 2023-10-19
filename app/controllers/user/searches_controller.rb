class User::SearchesController < ApplicationController
  def index
    @search_history = current_user.search_histories.order(created_at: :desc)
  end

  def search
    @range = params[:range]
    @word = params[:word]

    if @range == "User"
      @users = User.search_by_name(@word)
    else
      @locations = Location.search_by_place_name_or_address(@word)
    end

    current_user.search_histories.create(term: @word)
  end
end

