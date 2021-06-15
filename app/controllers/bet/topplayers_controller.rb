class Bet::TopplayersController < ApplicationController
  before_action :set_bet_topplayer, only: %i[ show edit update destroy ]

  # GET /bet/topplayers or /bet/topplayers.json
  def index
    @bet_topplayers = Bet::Topplayer.all
  end

  # GET /bet/topplayers/1 or /bet/topplayers/1.json
  def show
  end

  # GET /bet/topplayers/new
  def new
    @bet_topplayer = Bet::Topplayer.new
  end

  # GET /bet/topplayers/1/edit
  def edit
  end

  # POST /bet/topplayers or /bet/topplayers.json
  def create
    @bet_topplayer = Bet::Topplayer.new(bet_topplayer_params)

    respond_to do |format|
      if @bet_topplayer.save
        format.html { redirect_to @bet_topplayer, notice: "Topplayer was successfully created." }
        format.json { render :show, status: :created, location: @bet_topplayer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bet_topplayer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bet/topplayers/1 or /bet/topplayers/1.json
  def update
    respond_to do |format|
      if @bet_topplayer.update(bet_topplayer_params)
        format.html { redirect_to @bet_topplayer, notice: "Topplayer was successfully updated." }
        format.json { render :show, status: :ok, location: @bet_topplayer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bet_topplayer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bet/topplayers/1 or /bet/topplayers/1.json
  def destroy
    @bet_topplayer.destroy
    respond_to do |format|
      format.html { redirect_to bet_topplayers_url, notice: "Topplayer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bet_topplayer
      @bet_topplayer = Bet::Topplayer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bet_topplayer_params
      params.require(:bet_topplayer).permit(:participant_id, :player_id)
    end
end
