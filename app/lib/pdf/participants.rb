class Pdf::Participants
	include Pdf::PrintPdf
	include Pdf::ParticipantHelper 
	attr_reader :pdf, :printed_on, :participants, :rank


	def initialize(participants)
		@participants = participants.sort_by{|x| x.score_total}.reverse
		@printed_on = nldt(Time.now)

		@ranking = @participants.group_by{|x| x.score_total}.sort.reverse.map{|k,v| [k, @participants.index(v.first)+1,v.map(&:id)]}


		

		@pdf = Prawn::Document.new(defaults)


		print_participants

		footer_with_page_numbers

	end

	def print_participants
		participants.each_with_index do |participant, i|
			@rank = @ranking.find{|x| x[2].include?( participant.id )}[1]
			print_participant_page(participant)
			pdf.start_new_page unless i==participants.size-1
		end		
	end



end
