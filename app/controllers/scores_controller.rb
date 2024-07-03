class ScoresController < ApplicationController
	before_action :set_ranking

	def index
	    respond_to do |format|
	    
	      format.pdf {
	        send_data pdf.pdf.render, :filename=>"scores.pdf",:disposition => 'inline'
	      }
	      format.html
	    end
	end

	def download
	    send_data pdf.pdf.render, :filename=>"scores.pdf",:disposition => 'attachment'
	end


	private

	def pdf
		pdf = Pdf::Scores.new(@ranking)
	end

	def set_ranking
		@ranking = Participant.ranked
	end
end