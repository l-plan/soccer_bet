class Bet::GamesController < ApplicationController
  before_action :set_bet_game, only: %i[ show edit update destroy ]

  # GET /bet/games or /bet/games.json
  def index
    @bet_games = Bet::Game.all
  end

  # GET /bet/games/1 or /bet/games/1.json
  def show
  end

  # GET /bet/games/new
  def new
    @bet_game = Bet::Game.new
  end

  # GET /bet/games/1/edit
  def edit
  end

  # POST /bet/games or /bet/games.json
  def create
    @bet_game = Bet::Game.new(bet_game_params)

    respond_to do |format|
      if @bet_game.save
        format.html { redirect_to @bet_game, notice: "Game was successfully created." }
        format.json { render :show, status: :created, location: @bet_game }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bet_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bet/games/1 or /bet/games/1.json
  def update
    respond_to do |format|
      if @bet_game.update(bet_game_params)
        format.html { redirect_to @bet_game, notice: "Game was successfully updated." }
        format.json { render :show, status: :ok, location: @bet_game }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bet_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bet/games/1 or /bet/games/1.json
  def destroy
    @bet_game.destroy
    respond_to do |format|
      format.html { redirect_to bet_games_url, notice: "Game was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bet_game
      @bet_game = Bet::Game.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bet_game_params
      params.require(:bet_game).permit(:participant_id, :game_id, :home, :away)
    end
end
