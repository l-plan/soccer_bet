
class PrintScores
	include PrintPdf
	attr_reader :pdf, :participants


	def initialize(participants)
		@participants = participants
		

		@pdf = Prawn::Document.new(defaults)

		print_header

		print_ranking

		footer_with_page_numbers

	end


	def print_header
		pdf.text "freeks poule bijgewerkt t/m #{nldt(Time.now)}"

		h 20
	end


	def print_ranking

		arr = []
		rank = 0
		prev = 0

		participants.each do |part|
			rank+=1
			score = part.score_total

			(score == prev) ? print_rank = "" : print_rank = rank
			arr << [print_rank, part.name, score ]

			prev = score

		end


		pdf.table( arr, :column_widths => [100,200, 100], :cell_style=>cellstyle )


	end

	private
	
	def start_new_page?(lines,hight)
		 (lines.size * 12 + 15 ) > h.to_i-20 #(lines-size + line-header) is too big for page with footer...
	end					
end
