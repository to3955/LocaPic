class User::SearchesController < ApplicationController
  def index
    @search_history = current_user.search_histories.order(created_at: :desc)
  end

  def search
    @word = params[:word]

    if @word.present?
      @users = User.search_by_name(@word)
      @locations = Location.search_by_place_name_or_address(@word)
      #current_user.search_histories.create(term: @word)
    else
      # キーワードが空の場合に何らかの処理を行うか、メッセージを表示することもできます
      flash[:notice] = "キーワードを入力してください。"
      redirect_to user_searches_index_path
    end
  end
end
