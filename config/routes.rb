DataEngineering::Application.routes.draw do
  resources :imports, only: [:new, :create, :show]

  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  root 'imports#new'
end
