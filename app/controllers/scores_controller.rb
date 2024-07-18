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

	def write_all_final_scores
		Participant.all.each do |part|
			pdf = Pdf::Participant.new(part)
			pdf.write
		end


		redirect_to scores_url
	end


	private

	def pdf
		pdf = Pdf::Scores.new(@ranking)
	end

	def set_ranking
		@ranking = Participant.ranked
	end
end