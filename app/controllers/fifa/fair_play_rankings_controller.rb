class Fifa::FairPlayRankingsController < ApplicationController
  before_action :set_fifa_fair_play_ranking, only: %i[ show edit update destroy ]

  # GET /fifa/fair_play_rankings or /fifa/fair_play_rankings.json
  def index
    @rankings = Fifa::FairPlayRanking.all
  end

  # GET /fifa/fair_play_rankings/1 or /fifa/fair_play_rankings/1.json
  def show
  end

  # GET /fifa/fair_play_rankings/new
  def new
    @fifa_fair_play_ranking = Fifa::FairPlayRanking.new
  end

  # GET /fifa/fair_play_rankings/1/edit
  def edit
  end

  # POST /fifa/fair_play_rankings or /fifa/fair_play_rankings.json
  def create
    @fifa_fair_play_ranking = Fifa::FairPlayRanking.new(fifa_fair_play_ranking_params)

    respond_to do |format|
      if @fifa_fair_play_ranking.save
        format.html { redirect_to fifa_fair_play_ranking_url(@fifa_fair_play_ranking), notice: "Fair play ranking was successfully created." }
        format.json { render :show, status: :created, location: @fifa_fair_play_ranking }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @fifa_fair_play_ranking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fifa/fair_play_rankings/1 or /fifa/fair_play_rankings/1.json
  def update
    respond_to do |format|
      if @fifa_fair_play_ranking.update(fifa_fair_play_ranking_params)
        format.html { redirect_to fifa_fair_play_ranking_url(@fifa_fair_play_ranking), notice: "Fair play ranking was successfully updated." }
        format.json { render :show, status: :ok, location: @fifa_fair_play_ranking }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @fifa_fair_play_ranking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fifa/fair_play_rankings/1 or /fifa/fair_play_rankings/1.json
  def destroy
    @fifa_fair_play_ranking.destroy!

    respond_to do |format|
      format.html { redirect_to fifa_fair_play_rankings_url, notice: "Fair play ranking was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fifa_fair_play_ranking
      @fifa_fair_play_ranking = Fifa::FairPlayRanking.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def fifa_fair_play_ranking_params
      params.require(:fifa_fair_play_ranking).permit(:team_id, :points)
    end
end
