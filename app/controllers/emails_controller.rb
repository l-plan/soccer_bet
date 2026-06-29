class EmailsController < ApplicationController

	def index
		# file = Pdf::Scores.new(Participant.ranked).write
		# ParticipantMailer.with(user: nil).welcome_email.deliver
	end

	def latest
		Pdf::Scores.new(Participant.ranked).write

		Participant.all.select{|x| !x.email.nil?}.each do |participant|
		# Participant.all.select{|x| x.email == 'rolf@l-plan.nl'}.each do |participant|
			ParticipantMailer.latest_standings(participant: participant).deliver
		end

		redirect_to action: :index
	end

end