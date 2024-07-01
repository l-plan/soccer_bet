Rails.application.routes.draw do
  devise_for :users


  resources :home
  
  resources :calculations do
      collection do
        post :calculate_stage
        post :reset_stage
      end
  end


  resources :scores, only: :index

  resources :participants

  resources :players 

  resources :games


  resources :teams do
    
    collection do
      get :edit_many_redcards
      post :update_many_redcards
      get :edit_many_winners
      post :update_many_winners
    end   
  end

  resources :poule_rankings, only: :index do
      collection do
        get :edit_many
        post :update_many
        # get :calculate_rankings
        # get :reset_rankings
      end   
  end

  namespace :bet do
    resources :teams
    resources :players
    resources :games
  end

  root "home#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
