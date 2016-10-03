Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root "reviews#index"

  resources :reviews
  devise_for :users, controllers: {
    omniauth_callbacks: "users/callbacks"
    }, skip: :passwords
end
