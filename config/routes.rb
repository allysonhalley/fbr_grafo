Rails.application.routes.draw do
  resources :ways
  resources :edges
  resources :vertices
  resources :graphs

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  
  post 'run_algorithmm', to: 'ways#run_algorithmm', as: :run_algorithmm
  post 'run_ways', to: 'ways#run_ways', as: :run_ways

  post 'smaller_time', to: 'ways#smaller_time', as: :smaller_time
  post 'smaller_distance', to: 'ways#smaller_distance', as: :smaller_distance

  root to: 'graphs#index'
end
