class Bet::PlayersController < ApplicationController
  before_action :set_bet_player, only: %i[ show edit update destroy ]

  # GET /bet/players or /bet/players.json
  def index
    @bet_players = Bet::Player.all
  end

  # GET /bet/players/1 or /bet/players/1.json
  def show
  end

  # GET /bet/players/new
  def new
    @bet_player = Bet::Player.new
  end

  # GET /bet/players/1/edit
  def edit
  end

  # POST /bet/players or /bet/players.json
  def create
    @bet_player = Bet::Player.new(bet_player_params)

    respond_to do |format|
      if @bet_player.save
        format.html { redirect_to @bet_player, notice: "Player was successfully created." }
        format.json { render :show, status: :created, location: @bet_player }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bet_player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bet/players/1 or /bet/players/1.json
  def update
    respond_to do |format|
      if @bet_player.update(bet_player_params)
        format.html { redirect_to @bet_player, notice: "Player was successfully updated." }
        format.json { render :show, status: :ok, location: @bet_player }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bet_player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bet/players/1 or /bet/players/1.json
  def destroy
    @bet_player.destroy
    respond_to do |format|
      format.html { redirect_to bet_players_url, notice: "Player was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bet_player
      @bet_player = Bet::Player.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bet_player_params
      params.require(:bet_player).permit(:participant_id, :player_id, :stage, :score)
    end
end
