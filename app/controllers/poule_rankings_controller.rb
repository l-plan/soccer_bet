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




  private


end