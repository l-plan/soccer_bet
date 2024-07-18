class Pdf::Participant
	include Pdf::PrintPdf
	include Pdf::ParticipantHelper 
	attr_reader :pdf, :participant, :printed_on, :rank


	def initialize(participant)
		@participant = participant
		@printed_on = nldt(Time.now)

		@participants = Participant.includes({games: {game: [:home, :away] }}, {teams: [:team]}, players: :player).sort_by{|x| x.score_total}.reverse

		@ranking = @participants.group_by{|x| x.score_total}.sort.reverse.map{|k,v| [k, @participants.index(v.first)+1,v.map(&:id)]}
		@rank = @ranking.find{|x| x[2].include?( @participant.id )}[1]

		

		@pdf = Prawn::Document.new(defaults)

		print_participant_page(participant)


		footer_with_page_numbers



	end

	def write
		pdf.render_file( Rails.root.join('storage',"#{@participant.name.gsub(' ', '_')}_#{@participant.id}.pdf") )

	end

end











