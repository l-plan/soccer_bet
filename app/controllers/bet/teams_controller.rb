class Bet::TeamsController < ApplicationController
  before_action :set_bet_team, only: %i[ show edit update destroy ]

  # GET /bet/teams or /bet/teams.json
  def index
    @bet_teams = Bet::Team.all
  end

  # GET /bet/teams/1 or /bet/teams/1.json
  def show
  end

  # GET /bet/teams/new
  def new
    @bet_team = Bet::Team.new
  end

  # GET /bet/teams/1/edit
  def edit
  end

  # POST /bet/teams or /bet/teams.json
  def create
    @bet_team = Bet::Team.new(bet_team_params)

    respond_to do |format|
      if @bet_team.save
        format.html { redirect_to @bet_team, notice: "Team was successfully created." }
        format.json { render :show, status: :created, location: @bet_team }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bet_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bet/teams/1 or /bet/teams/1.json
  def update
    respond_to do |format|
      if @bet_team.update(bet_team_params)
        format.html { redirect_to @bet_team, notice: "Team was successfully updated." }
        format.json { render :show, status: :ok, location: @bet_team }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bet_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bet/teams/1 or /bet/teams/1.json
  def destroy
    @bet_team.destroy
    respond_to do |format|
      format.html { redirect_to bet_teams_url, notice: "Team was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bet_team
      @bet_team = Bet::Team.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bet_team_params
      params.require(:bet_team).permit(:participant_id, :stage, :team_id)
    end
end
