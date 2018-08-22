Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :events
      resources :user_events
      resources :comments , only: [:index, :create, :show]
      resources :users, only: [:create, :show]
      get "/getevents", to: 'events#get_events'
      post "/login", to: 'users#login'
      get "/current_user", to: 'users#get_current_user'
      get "/users/:id/events", to: 'users#get_events'
      post "/users/:id/events", to: 'users#set_events'
      delete "/users/:id/events", to: 'users#delete_event'
    end
  end
end
