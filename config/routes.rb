Rails.application.routes.draw do
  resources :posts
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "main" , to:"users#login"
  post "main" , to:"users#checklog"
  get "post" , to:"users#showpost"
  get "create_fast" , to:"users#create_fast"
end
