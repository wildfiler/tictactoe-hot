# frozen_string_literal: true

Rails.application.routes.draw do
  root 'players#new'
  resources :games, only: %i[new show create]
  resource :players, only: %i[new create]
end
