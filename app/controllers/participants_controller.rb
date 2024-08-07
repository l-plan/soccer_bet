class ParticipantsController < ApplicationController
  before_action :set_participant, only: %i[ show download edit update destroy ]

  # GET /participants or /participants.json
  def index
    # @participants = Participant.includes(:games, :teams, :players)
    @participants = Participant.includes({games: {game: [:home, :away] }}, {teams: [:team]}, players: :player)

        respond_to do |format|
      
        format.pdf {
          pdf = Pdf::Participants.new(@participants)

          send_data pdf.pdf.render, :filename=>"participants.pdf",:disposition => 'inline'

        }
        format.html
      end
  end

  def download
          pdf = Pdf::Participant.new(@participant)

          send_data pdf.pdf.render, :filename=>"#{@participant.name.gsub(' ', '_')}.pdf",:disposition => 'attachment'

  end

  # GET /participants/1 or /participants/1.json
  def show
      respond_to do |format|
      
        format.pdf {
          pdf = Pdf::Participant.new(@participant)

          send_data pdf.pdf.render, :filename=>"participant.pdf",:disposition => 'inline'

        }
        format.html
      end

  end

  # GET /participants/new
  def new
    @participant = Participant.new
  end

  # GET /participants/1/edit
  def edit
  end

  # POST /participants or /participants.json
  def create
    @participant = Participant.new(participant_params)

    respond_to do |format|
      if @participant.save
        format.html { redirect_to @participant, notice: "Participant was successfully created." }
        format.json { render :show, status: :created, location: @participant }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /participants/1 or /participants/1.json
  def update
    respond_to do |format|
      if @participant.update(participant_params)
        format.html { redirect_to @participant, notice: "Participant was successfully updated." }
        format.json { render :show, status: :ok, location: @participant }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participants/1 or /participants/1.json
  def destroy
    @participant.destroy
    respond_to do |format|
      format.html { redirect_to participants_url, notice: "Participant was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_participant
      @participant = Participant.includes({games: {game: [:home, :away] }}, {teams: [:team]}, players: :player).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def participant_params
      params.require(:participant).permit(:name, :email)
    end
end
