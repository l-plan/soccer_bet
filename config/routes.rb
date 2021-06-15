Rails.application.routes.draw do
  namespace :bet do
    resources :teams
  end
  namespace :bet do
    resources :topplayers
  end
  namespace :bet do
    resources :topscorers
  end
  resources :participants
  namespace :bet do
    resources :games
  end
  resources :players
  resources :games
  resources :teams
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
