Rails.application.routes.draw do
  # root "articles#index"
  resources :games, only: %i(show)
end
