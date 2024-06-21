class NavigationController < ApplicationController
  # before_action :set_game, only: %i[ show edit update destroy calculate reset_scores]

  # GET /games or /games.json
  def show
    render '/navigation/menu'
  end

  def destroy
  end


end
