class PlayersController < ApplicationController
  before_action :set_player, only: %i[ show edit update destroy calculate_topplayer reset_topplayer_scores calculate_topscorer reset_topscorer_scores]

  # GET /players or /players.json
  def index
    @players = Player.all
  end

  # GET /players/1 or /players/1.json
  def show
  end

  # GET /players/new
  def new
    @player = Player.new
  end

  # GET /players/1/edit
  def edit
  end

  # POST /players or /players.json
  def create
    @player = Player.new(player_params)

    respond_to do |format|
      if @player.save
        format.html { redirect_to @player, notice: "Player was successfully created." }
        format.json { render :show, status: :created, location: @player }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /players/1 or /players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to @player, notice: "Player was successfully updated." }
        format.json { render :show, status: :ok, location: @player }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1 or /players/1.json
  def destroy
    @player.destroy
    respond_to do |format|
      format.html { redirect_to players_url, notice: "Player was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def edit_many_topscorers
    @topscorers = Player.joins(:topscorers)
  end

  def update_many_topscorers

    if Player.topscorer
      # Player.topscorer.reset_topscorer_scores
      # Player.topscorer.update_attribute(:top, nil)
    end

    unless params[:id].blank?
      @topscorer = Player.find(params[:id])
      @topscorer.update_attribute(:top, true)
      
      @topscorer.topscorers.each{|x| x.update_attribute(:score, 5)}
    end
    
    redirect_to games_url
  end

  def edit_many_topplayers
    @topplayers = Player.joins(:topplayers)
  end

  def update_many_topplayers
    if Player.topplayer
      # Player.topplayer.reset_topplayer_scores
      # Player.topplayer.update_attribute(:best, nil)
    end

    unless params[:id].blank?
      @topplayer = Player.find(params[:id])
      @topplayer.update_attribute(:best, true)
      
      @topplayer.topplayers.each{|x| x.update_attribute(:score, 5)}
    end
    
    redirect_to games_url
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def player_params
      params.require(:player).permit(:name, :initials, :team_id)
    end
end
