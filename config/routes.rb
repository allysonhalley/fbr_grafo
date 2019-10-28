Rails.application.routes.draw do
  resources :edges
  resources :vertices
  resources :graphs

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  
  get 'start_algoritm', to: 'graphs#start_algoritm'

  root to: 'graphs#index'
end
