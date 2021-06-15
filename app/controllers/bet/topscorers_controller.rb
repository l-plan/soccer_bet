class Bet::TopscorersController < ApplicationController
  before_action :set_bet_topscorer, only: %i[ show edit update destroy ]

  # GET /bet/topscorers or /bet/topscorers.json
  def index
    @bet_topscorers = Bet::Topscorer.all
  end

  # GET /bet/topscorers/1 or /bet/topscorers/1.json
  def show
  end

  # GET /bet/topscorers/new
  def new
    @bet_topscorer = Bet::Topscorer.new
  end

  # GET /bet/topscorers/1/edit
  def edit
  end

  # POST /bet/topscorers or /bet/topscorers.json
  def create
    @bet_topscorer = Bet::Topscorer.new(bet_topscorer_params)

    respond_to do |format|
      if @bet_topscorer.save
        format.html { redirect_to @bet_topscorer, notice: "Topscorer was successfully created." }
        format.json { render :show, status: :created, location: @bet_topscorer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bet_topscorer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bet/topscorers/1 or /bet/topscorers/1.json
  def update
    respond_to do |format|
      if @bet_topscorer.update(bet_topscorer_params)
        format.html { redirect_to @bet_topscorer, notice: "Topscorer was successfully updated." }
        format.json { render :show, status: :ok, location: @bet_topscorer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bet_topscorer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bet/topscorers/1 or /bet/topscorers/1.json
  def destroy
    @bet_topscorer.destroy
    respond_to do |format|
      format.html { redirect_to bet_topscorers_url, notice: "Topscorer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bet_topscorer
      @bet_topscorer = Bet::Topscorer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bet_topscorer_params
      params.require(:bet_topscorer).permit(:participant_id, :player_id)
    end
end
