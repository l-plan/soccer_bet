class ScoresController < ApplicationController

	def index
		@participants = Participant.includes(:games, :teams, :players).sort_by{|x| x.score_total}.reverse


	    respond_to do |format|
	    
	      format.pdf {
	        pdf = PrintScores.new(@participants)

	        send_data pdf.pdf.render, :filename=>"scores.pdf",:disposition => 'inline'

	      }
	      format.html
	    end

	end
end