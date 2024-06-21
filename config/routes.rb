Rails.application.routes.draw do

  # resource :navigation, only: [:show, :destroy]
  resources :scores

  resources :participants

  resources :players do
       member  do
        get :calculate_topplayer
        get :calculate_topscorer
        get :reset_topplayer_scores
        get :reset_topscorer_scores
      end

      collection do
        get :edit_many_topplayers
        post :update_many_topplayers
        get :edit_many_topscorers
        post :update_many_topscorers
      end
        
  end

  resources :games do 
      member  do
        get :calculate
        get :reset_scores
      end  

      collection do
        get :calculate_stage_scores
        get :reset_stage_scores
      end
  end

  resources :teams do
       member  do
        get :calculate_winner
        get :calculate_redcard
        get :reset_winner_scores
        get :reset_redcard_scores
      end

      collection do
        get :edit_many_redcards
        post :update_many_redcards
        get :edit_many_winners
        post :update_many_winners
      end    
  end


  namespace :bet do
    resources :teams
    resources :players
    resources :games
  end

  root "scores#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
