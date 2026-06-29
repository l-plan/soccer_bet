class ParticipantMailer < ApplicationMailer

	before_action :set_greet


	def latest_standings

		@participant = params[:participant]
		@xtra = params[:xtra]

		str = Date.today.strftime.gsub(/-/, '')

		attachments["standings_#{str}.pdf"] = File.read(Rails.root.join('storage',"standings_#{str}.pdf") )

		mail( to: @participant.email, subject: "Tussenstand Freek's poule #{Date.today} #{@xtra}" )
	
	end

	def input

		@participant = params[:participant]
		@xtra = params[:xtra]

		str = Date.today.strftime.gsub(/-/, '')

		attachments["standings_#{str}.pdf"] = File.read(Rails.root.join('storage',"standings_#{str}.pdf") )

		mail( to: @participant.email, subject: "Jouw ingevoerde gegevens #{Date.today} #{@xtra}" )
	
	end

	private

	def set_greet
		case Time.now.hour
			when 0..11
				@greet = "goedemorgen"
			when 12..17
				@greet = "goedemiddag"
			else
				@greet = "goedenavond"
		end
	end
end
