Rails.application.routes.draw do
  resources :comments
  resources :user_events
  resources :users
  namespace :api do
    namespace :v1 do
      get "/getevents", to: 'events#get_events'
    end
  end
end
