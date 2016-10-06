Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root "reviews#index"

  resources :reviews
  resources :comments, only: [:create, :destroy]
  devise_for :users, controllers: {
    omniauth_callbacks: "users/callbacks"
    }, skip: :passwords
  resources :users, :only => [:show]
  namespace :admin do 
  	resources :users
  end
end
