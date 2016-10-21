Rails.application.routes.draw do
  require "sidekiq/web"
  mount Ckeditor::Engine => '/ckeditor'
  root "reviews#index"

  namespace :admins do
    authenticate :user, -> u {u.admin?} do
      mount Sidekiq::Web => "/sidekiq"
    end
    resources :devices
    resources :users
    resources :reviews
  end

  resources :comments, only: [:index, :create, :destroy]
  resources :devices, only: [:index, :show]
  resources :reviews
  resources :search_suggestions
  devise_for :users, controllers: {
    omniauth_callbacks: "users/callbacks"
    }, skip: :passwords
  resources :users, :only => [:show]
  post "/users/:id/unlink" => "users/unlink#facebook", as: "unlink_facebook"
end
