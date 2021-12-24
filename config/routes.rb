Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    devise_for :users
    root to: "foods#index"
    resources :categories
    resources :foods
    resources :order_addresses
    resources :order_items
    resources :users
    resources :orders, only: [:edit, :update, :destroy, :index]
    resources :reviews, only: [:new, :create]
    scope "/orders" do
      get "cart", to: "orders#show"
      post "accept", to: "orders#accept"
      post "add_address", to: "orders#create_address"
      post "confirm", to: "orders#confirm"
    end
  end
end
