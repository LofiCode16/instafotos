Rails.application.routes.draw do

  resources :posts, only: %i[index new create destroy]

  root 'posts#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
