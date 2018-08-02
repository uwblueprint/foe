Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks]
  namespace :auth do
    resources :resend_confirmation, only: [:create]
  end

  # match 'admin/login', to: 'devise_token_auth/sessions#new', via: [:get]
  # match 'admin/login', to: 'devise_token_auth/sessions#create', via: [:create]
  # match 'admin/logout', to: 'devise_token_auth/sessions#destroy', via: [:delete]
  namespace :admin do
    # resources :sessions, only: [:new, :create, :destroy]
    resources :sightings, only: [:index, :show]
  end

  resources :sightings

  match 'confirm', to: 'pages#confirm', via: [:get]
end
