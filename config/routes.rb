Rails.application.routes.draw do
  root 'results#index'
  get '/results/', to: 'results#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/results/schools/', to: 'results#schools'
  resources :results, param: :name
  get '/data/:name', to: 'results#download'
end
