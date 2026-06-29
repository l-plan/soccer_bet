class EmailsController < ApplicationController

	def index
		# file = Pdf::Scores.new(Participant.ranked).write
		# ParticipantMailer.with(user: nil).welcome_email.deliver
	end

	def latest
		@xtra = params[:xtra]

		Pdf::Scores.new(Participant.ranked).write

		Participant.all.select{|x| !x.email.nil?}.each do |participant|
		# Participant.all.select{|x| x.email == 'rolf@l-plan.nl'}.each do |participant|

			ParticipantMailer.with( participant: participant, xtra: @xtra).latest_standings.deliver_later
			participant.messages.latest.create(sent_on: Time.now)
		end

		redirect_to action: :index
	end

	def input
		@xtra = params[:xtra]

		Pdf::Scores.new(Participant.ranked).write

		Participant.all.select{|x| !x.email.nil?}.each do |participant|
		# Participant.all.select{|x| x.email == 'rolf@l-plan.nl'}.each do |participant|

			ParticipantMailer.with( participant: participant, xtra: @xtra).input.deliver_now
			participant.messages.input.create(sent_on: Time.now)
		end

		redirect_to action: :index
	end
end