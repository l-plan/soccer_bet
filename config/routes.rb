Rails.application.routes.draw do
  namespace :fifa do
    resources :fair_play_rankings
    resources :rankings
  end
  devise_for :users


  resources :home, only: :index 
  
  resources :calculations do
      collection do
        post :calculate_stage
        post :reset_stage
        post :calculate_fifa_poule_rankings
        post :reset_fifa_poule_rankings
        post :calculate_participants_poule_rankings
        post :reset_participants_poule_rankings
      end
  end


  resources :scores, only: :index do
    collection do
      get :download
      post :write_all_final_scores

    end
  end

  resources :participants do
    member do
      get :download
    end
  end

  resources :players do
    collection do
      get :edit_many_topplayers
      post :update_many_topplayers
      get :edit_many_topscorers
      post :update_many_topscorers

    end
  end

  resources :games


  resources :teams do
    
    collection do
      get :edit_many_redcards
      get :poule_rankings
      post :update_many_redcards

      get :edit_many_sixteenfinalists
      get :edit_many_eightfinalists
      get :edit_many_quarterfinalists
      get :edit_many_semifinalists
      get :edit_many_finalists
      get :edit_many_winners

      post :update_many_sixteenfinalists
      post :update_many_eightfinalists
      post :update_many_quarterfinalists
      post :update_many_semifinalists
      post :update_many_finalists
      post :update_many_winners
    end   
  end

  resources :poule_rankings, only: :index do
      collection do
        get :edit_many
        post :update_many
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
