class ScoresController < ApplicationController

	def index
		# @participants = Participant.includes(:games, :teams, :players).sort_by{|x| x.score_total}.reverse


		@ranking = Participant.ranked

		
		


	    respond_to do |format|
	    
	      format.pdf {
	        pdf = Pdf::Scores.new(@ranking)

	        send_data pdf.pdf.render, :filename=>"scores.pdf",:disposition => 'inline'

	      }
	      format.html
	    end

	end
end