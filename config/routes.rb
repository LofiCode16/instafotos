Rails.application.routes.draw do

  devise_for :users
  resources :posts, only: %i[index new create destroy]
  
  post 'friends/:friend_id/add', to: 'friends#create', as: 'new_friend'
  delete 'friends/:friend_id', to: 'friends#destroy', as: 'destroy_friend'

  root 'posts#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
