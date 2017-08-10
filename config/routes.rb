Rails.application.routes.draw do
  # users routes

  post 'users/create', action: :create, controller: 'users'
  put 'users/update/:id', action: :update, controller: 'users'

  # auth routes

  post 'auth/login', action: :login, controller: 'authenticate'
  post 'auth/logout', action: :logout, controller: 'authenticate'
end
