Rails.application.routes.draw do
  # ■root
  root to: "knowhows#index"
  # ■mypage
  get "/mypage", to: "users#show"
  # ■admin_page
  get "/admin_page", to: "users#admin_page"

  # ■user
  resource :users
  get "/users/index", as: "users_index", to: "users#index"
  delete "/users/:id/destroy", as: "users_destroy", to: "users#destroy"
  patch "/users/:id/change_user_type", as: "change_user_type", to: "users#change_user_type"
  put "/users/:id/change_user_type", to: "users#change_user_type"
# ★★★後で修正する！！★★★
  # resource :users do
  #   collection do
  #     post :confirm
  #   end
  # end

  # ■knowhow
  resources :knowhows

  # ■session
  get "/users/login", to: "sessions#new"
  post "/users/login", to: "sessions#create"
  delete "/users/:id/logout", as: "users_delete", to: "sessions#destroy"

  # ■category
  resources :categories, only: [:index, :create, :update, :destroy]

  # ■language
  resources :languages, only: [:index, :create, :update, :destroy]


# ★★★後で修正する！！★★★
  # # ■like
  # resources :likes, only: [:index, :create, :destroy] do
  #   collection do
  #     get :like_add
  #     get :like_delete
  #   end
  # end
# ★★★後で修正する！！★★★
end
