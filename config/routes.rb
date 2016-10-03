Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root "reviews#index"

  resources :reviews
  devise_for :users
end
