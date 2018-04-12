Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  get '/events' => 'events#index'
  get '/events/:id' => 'events#show'
  post '/events' => 'events#create'
  patch '/events/:id' => 'events#update'
  delete '/events/:id' => 'events#destroy'
  get '/forums' => 'forums#index'
  post '/forums' => 'forums#create'
  patch '/forums/:id' => 'forums#update'
  delete '/forums/:id' => 'forums#destroy'
end
