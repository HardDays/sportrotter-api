Rails.application.routes.draw do
  
  # users routes

  get 'users/get_me', action: :get_me, controller: 'users'
  post 'users/create', action: :create, controller: 'users'
  put 'users/update', action: :update, controller: 'users'

  # auth routes

  post 'auth/login', action: :login, controller: 'authenticate'
  post 'auth/logout', action: :logout, controller: 'authenticate'

  # message routes

  get 'messages/show/:id', action: :show, controller: 'messages'
  get 'messages/show_sent', action: :show_sent, controller: 'messages'
  get 'messages/show_received', action: :show_received, controller: 'messages'
  post 'messages/create', action: :create, controller: 'messages'
  post 'messages/mark_read/:id', action: :mark_read, controller: 'messages' 
end
