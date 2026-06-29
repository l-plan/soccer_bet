class ParticipantMailer < ApplicationMailer


	def latest_standings(participant)


	@participant = participant.values.first

	case Time.now.hour
		when 0..11
			@greet = "goedemorgen"
		when 12..17
			@greet = "goedemiddag"
		else
			@greet = "goedenavond"
	end

	str = Date.today.strftime.gsub(/-/, '')

	attachments["standings_#{str}.pdf"] = File.read(Rails.root.join('storage',"standings_#{str}.pdf") )

	mail( to: @participant.email, subject: "Tussenstand Freek's poule #{Date.today}" )
	
	end
end
