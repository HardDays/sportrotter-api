Rails.application.routes.draw do
  # users routes
  get 'users/get/:id', action: :get, controller: 'users'
  get 'users/get_all', action: :get_all, controller: 'users'
  get 'users/get_professionals', action: :get_professionals, controller: 'users'
  get 'users/get_me', action: :get_me, controller: 'users'
  post 'users/create', action: :create, controller: 'users'
  post 'users/change_password', action: :change_password, controller: 'users'
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
  get 'activities/get_all', action: :index, controller: 'activities'
  get 'activities/get/:id', action: :show, controller: 'activities'
  get 'activities/discover', action: :discover, controller: 'activities'
  post 'activities/create', action: :create, controller: 'activities'
  post 'activities/rate', action: :rate, controller: 'activities'
  post 'activities/unrate', action: :unrate, controller: 'activities'
  put 'activities/update/:id', action: :update, controller: 'activities'
  delete 'activities/delete/:id', action: :delete, controller: 'activities'

  # bookings routes
  get 'bookings/get_my_bookings', action: :get_my_bookings, controller: 'bookings'
  get 'bookings/get_future_bookings', action: :get_future_bookings, controller: 'bookings'
  get 'bookings/get_past_bookings', action: :get_past_bookings, controller: 'bookings'
  get 'bookings/get_activity_bookings/:id', action: :get_activity_bookings, controller: 'bookings'
  post 'bookings/validate_booking', action: :validate_booking, controller: 'bookings'
  post 'bookings/create', action: :create, controller: 'bookings'
  put 'bookings/update/:id', action: :update, controller: 'bookings'
  delete 'bookings/delete/:id', action: :delete, controller: 'bookings'

  # images routes
  get 'images/get/:id', action: :show, controller: 'images'

  # comments routes
  get 'comments/get_all', action: :index, controller: 'comments'
  get 'comments/get/:id', action: :show, controller: 'comments'
  post 'comments/create', action: :create, controller: 'comments'
  delete 'comments/delete/:id', action: :delete, controller: 'comments'

end
