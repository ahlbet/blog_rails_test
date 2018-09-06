Rails.application.routes.draw do
  devise_for :users
  resources :posts
  resources :categories
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'categories/index'
  get 'posts/index'
  root 'posts#index'
end
