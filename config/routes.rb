Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resources :posts, only: %i[index create destroy]

  post 'repost', to: 'reposts#create', as: 'repost'
  get 'reposts/:id/new', to: 'reposts#new', as: 'new_repost'

  post 'friends/:friend_id/add', to: 'friends#create', as: 'new_friend'
  delete 'friends/:friend_id', to: 'friends#destroy', as: 'destroy_friend'

  root 'posts#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
