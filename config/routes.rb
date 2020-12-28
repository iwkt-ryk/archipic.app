Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  post "likes/:post_id/create" => "likes#create"
  post "likes/:post_id/destroy" => "likes#destroy"

  get "posts/index" => "posts#index"
  get "posts/:id/new" => "posts#new"
  get "posts/:id" => "posts#show"
  post "posts/create" => "posts#create"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  post "posts/:id/destroy" => "posts#destroy"
  
  get "/" => "welcome#index"

  get "users/signup" => "users#new"
  post "users/create" => "users#create"
  get "users/:id" => "users#show"
  get "users/:id/edit" => "users#edit"
  post "users/:id/update" => "users#update"
  get "login" => "users#login_page"
  post "login" => "users#login"
  post "logout" => "users#logout"
  get "users/:id/likes" => "users#likes"




end