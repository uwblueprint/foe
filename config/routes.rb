Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks]

  namespace :auth do
    resources :resend_confirmation, only: [:create]
  end

  resources :sightings

  match 'confirm', to: 'pages#confirm', via: [:get]
end
