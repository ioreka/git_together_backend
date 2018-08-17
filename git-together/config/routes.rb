Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :events
      resources :user_events
      resources :users
      resources :comments
      get "/getevents", to: 'events#get_events'
    end
  end
end
