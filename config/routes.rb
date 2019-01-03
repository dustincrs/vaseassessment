Rails.application.routes.draw do
  get 'file/download'
  root 'welcome_controller#index'

  resources :survey

  get '/search', to: 'search#search'
end
