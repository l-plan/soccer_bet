class PouleRankingsController < ApplicationController


  def index
    @poules = Team.all.group_by{|x| x.poule}
  end

  def edit_many
    @poules = Team.all.group_by{|x| x.poule}
  end

  def update_many

  	@poule = params[:poule]
  	params[:teams].values.each do |h|
  		@team = ::Team.find(h["id"]).update_attribute(:poule_rank, h["poule_rank"])
  	end

	# update_poule_ranking(@poule)

  	redirect_to action: :edit_many
  end

  def calculate_rankings
    Bet::Team.calculate_poule_rank_score
    Bet::Team.calculate_poule_bonus
    redirect_to scores_url

  end

  def reset_rankings
    Bet::Team.reset_poule_rank_score
    Bet::Team.reset_poule_bonus
    redirect_to scores_url
  end


  private


end