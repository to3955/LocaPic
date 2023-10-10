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
  get '/searches/search', to: 'searches#search', as: 'search'
  resources :searches, only: [:index]
  resources :posts do
  resources :replies, only: [:create, :destroy]
  resource :likes, only: [:create, :destroy]
  member do
      get 'show_detail' # 詳細ページへのルートを追加
    end
  end
   get'users/mypage', :to =>'users#show'
   get 'information/edit', to: 'users#edit', as: 'edit_information'
   patch 'users/information' => "users#update"
   post 'users/confirm' => "users#confirm"
   patch 'users/out' => "users#out"
  resources :users do
    member do
      get :follows, :followers
    end
      resource :relationships, only: [:index, :create, :destroy]

       get "search" => "users#search"
    end
  resources :locations, only: [:index, :show]

  end


   namespace :admin do

    root to: "homes#top"
    resources :users, only: [:index, :show, :edit, :update]
    resources :posts, only: [:index, :destroy]
  end

 end
