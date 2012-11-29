ZendeskHelpRails::Application.routes.draw do
  devise_for :users

  root to: 'tickets#new'

  resources :tickets
end
