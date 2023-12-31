Rails.application.routes.draw do

   # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # 顧客用
# URL /customers/sign_in ...
# 顧客用
# URL /customers/sign_in ...
devise_for :user,skip: [:passwords], controllers: {
  registrations: "user/registrations",
  sessions: 'user/sessions'
}

post 'user/guest_login', to: 'user/sessions#guest_login'

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

devise_scope :user do
    post 'users/guest_sign_in', to: 'user/sessions#guest_sign_in'
 end

  root to: 'user/homes#top' # モジュール構造を含めて正確に指定
  get 'home/about', to: 'user/homes#about', as: 'about' # モジュール構造を含めて正確に指定

  scope module: :user do
  get '/search', to: 'searches#search'
  resources :searches, only: [:index]
  get 'users/posts' => 'posts#show'
  resources :posts do
    member do
      get 'show_detail' # 詳細ページへのルートを追加
    end
    resources :replies, only: [:create, :destroy]
    resource :likes, only: [:create, :destroy]
  end

  get 'users/likes', to: 'likes#index', as: 'user_likes' # いいね一覧へのルートを追加
  get 'users/mypage', :to => 'users#show'
  get 'information/edit', to: 'users#edit', as: 'edit_information'
  patch 'users/information' => "users#update"
  get 'users/confirm' => "users#confirm"
  patch 'users/out' => "users#out"

  resources :users do
    member do
      get :follows, :followers
    end
    resource :relationships, only: [:index, :create, :destroy]
  end

  resources :locations, only: [:new, :index, :show]
end


  namespace :admin do
  root to: "homes#top"

  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get 'user_posts', to: 'posts#user_posts', as: :user_posts
    end
  end

  resources :posts, only: [:index, :show, :destroy]
  resources :replies, only: [:destroy]
end

 end
