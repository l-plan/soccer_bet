class TeamsController < ApplicationController
  before_action :set_team, only: %i[ show edit update destroy calculate_winner reset_winner_scores calculate_redcard reset_redcard_scores]

  # GET /teams or /teams.json
  def index
    @teams = Team.all
  end

  # GET /teams/1 or /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams or /teams.json
  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: "Team was successfully created." }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1 or /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: "Team was successfully updated." }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1 or /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: "Team was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  def edit_many_winners
    @winners = Team.all
  end

  def update_many_winners

    if Team.winner
      Team.winner.reset_winner_scores
      Team.winner.update_attribute(:winner, nil)
    end

    unless params[:id].blank?
      @winner = Team.find(params[:id])
      @winner.update_attribute(:winner, true)
      
      @winner.winners.each{|x| x.update_attribute(:score, 5)}
    end
    
    redirect_to games_url
  end

  def edit_many_redcards
    @redcards = Team.all
  end

  def update_many_redcards

    if Team.redcard
      Team.redcard.reset_redcard_scores
      Team.redcard.update_attribute(:red, nil)
    end

    unless params[:id].blank?
      @redcard = Team.find(params[:id])
      @redcard.update_attribute(:red, true)
      
      @redcard.redcards.each{|x| x.update_attribute(:score, 5)}
    end
    
    redirect_to games_url
  end

  def calculate_winner
    @team.calculate_winner
    redirect_to games_url
  end


  def reset_winner_scores
    @team.reset_winner_scores
    redirect_to games_url
  end

  def calculate_redcard
    # @team.calculate_redcard
    Team.calculate_redcard
    redirect_to games_url
  end


  def reset_redcard_scores
    # @team.reset_redcard_scores
    Team.reset_redcard
    redirect_to scores_url
  end

  def calculate_eightfinalists
    Team.calculate_eightfinalists
    redirect_to scores_url
  end

  def reset_eightfinalists
    Team.reset_eightfinalists
    redirect_to scores_url
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def team_params
      params.require(:team).permit(:name)
    end
end
