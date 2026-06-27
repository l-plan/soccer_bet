class Fifa::RankingsController < ApplicationController
  before_action :set_fifa_ranking, only: %i[ show edit update destroy ]

  # GET /fifa/rankings or /fifa/rankings.json
  def index
    @rankings = Fifa::Ranking.all
  end

  # GET /fifa/rankings/1 or /fifa/rankings/1.json
  def show
  end

  # GET /fifa/rankings/new
  def new
    @fifa_ranking = Fifa::Ranking.new
  end

  # GET /fifa/rankings/1/edit
  def edit
  end

  # POST /fifa/rankings or /fifa/rankings.json
  def create
    @fifa_ranking = Fifa::Ranking.new(fifa_ranking_params)

    respond_to do |format|
      if @fifa_ranking.save
        format.html { redirect_to fifa_ranking_url(@fifa_ranking), notice: "Ranking was successfully created." }
        format.json { render :show, status: :created, location: @fifa_ranking }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @fifa_ranking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fifa/rankings/1 or /fifa/rankings/1.json
  def update
    respond_to do |format|
      if @fifa_ranking.update(fifa_ranking_params)
        format.html { redirect_to fifa_ranking_url(@fifa_ranking), notice: "Ranking was successfully updated." }
        format.json { render :show, status: :ok, location: @fifa_ranking }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @fifa_ranking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fifa/rankings/1 or /fifa/rankings/1.json
  def destroy
    @fifa_ranking.destroy!

    respond_to do |format|
      format.html { redirect_to fifa_rankings_url, notice: "Ranking was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fifa_ranking
      @fifa_ranking = Fifa::Ranking.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def fifa_ranking_params
      params.require(:fifa_ranking).permit(:team_id, :points)
    end
end
