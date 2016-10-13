Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root "reviews#index"

  resources :devices, only: [:index, :show]
  resources :reviews
  resources :comments, only: [:create, :destroy]
  devise_for :users, controllers: {
    omniauth_callbacks: "users/callbacks"
    }, skip: :passwords
  resources :users, :only => [:show]
  post "/users/:id/unlink" => "users/unlink#facebook", as: "unlink_facebook"

  namespace :admins do
    resources :devices
  	resources :users
  end
end
