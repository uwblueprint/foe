Rails.application.routes.draw do
  resources :sightings
  post 'auth/:provider', to: 'auth#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
