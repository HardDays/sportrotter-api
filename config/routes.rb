Rails.application.routes.draw do
  # users routes
  get 'users/get_all', action: :get_all, controller: 'users'
  get 'users/get_professionals', action: :get_professionals, controller: 'users'
  get 'users/get_me', action: :get_me, controller: 'users'
  post 'users/create', action: :create, controller: 'users'
  put 'users/update', action: :update, controller: 'users'

  # auth routes
  post 'auth/login', action: :login, controller: 'authenticate'
  post 'auth/logout', action: :logout, controller: 'authenticate'

  # message routes
  get 'messages/get/:id', action: :show, controller: 'messages'
  get 'messages/get_sent', action: :show_sent, controller: 'messages'
  get 'messages/get_received', action: :show_received, controller: 'messages'
  post 'messages/create', action: :create, controller: 'messages'
  post 'messages/mark_read/:id', action: :mark_read, controller: 'messages' 

  # activities routes
  get 'activities/get/:id', action: :show, controller: 'activities'
  post 'activities/create', action: :create, controller: 'activities'
  put 'activities/update/:id', action: :update, controller: 'activities'
  delete 'activities/delete/:id', action: :delete, controller: 'activities'

end
