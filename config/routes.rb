Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  get '/events' => 'events#index'
  get '/events/:id' => 'events#show'
  post '/events' => 'events#create'
end
