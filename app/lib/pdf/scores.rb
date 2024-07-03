class Pdf::Scores
	include Pdf::PrintPdf
	attr_reader :pdf, :ranking


	def initialize(ranking)
		@ranking = ranking
		

		@pdf = Prawn::Document.new(defaults)

		print_header

		print_ranking

		footer_with_page_numbers

	end


	def print_header
		h -20
		arr = [["freeks poule bijgewerkt t/m #{nldt(Time.now)}","<color rgb='0000FF'><u><link href='/scores/download'>download</link></u></color>","<color rgb='0000FF'><u><link href='/scores'>close pdf</link></u></color>"]]
		pdf.table( arr, :column_widths =>[275, 80, 80], :cell_style=>cellstyle, position: 0 ) do
			column(0).style :align => :left 
			column(1).style :align => :left, :inline_format => true
			column(2).style :align => :right, :inline_format => true
		end

		

		h 1
		arr = [%w(rank name games  ranking bonus eightfinal quarterfinal semifinal finale winner redcard topplayer topscorer total)]
		# pdf.table( arr, :column_widths => [50,100,30,30,30,30,30, 30, 30,30,30, 30, 30, 30], :cell_style=> vertical_style) 
		pdf.table( arr, :column_widths => [50,100,25,25,25,25,25, 25, 25,25,25, 25, 25, 30], :cell_style=> vertical_style) 
	end


	def print_ranking

		arr = []
		prev = 0

			# arr << %w(rank name games eightfinal quarterfinal semifinal finale winner redcard topplayer topscorer total)

		ranking.each do |part, v|
			rank 	= v[0]
			score 	= v[1]

			(score == prev) ? print_rank = "" : print_rank = rank

			g = part.games.map(&:score).compact.sum
			
			pr = part.teams.select{|x| x.stage == 'poule_score'}.map(&:score).compact.sum
			pb = part.teams.select{|x| x.stage == 'poule_bonus'}.map(&:score).compact.sum
			e = part.teams.select{|x| x.stage == 'eightfinal'}.map(&:score).compact.sum
			q = part.teams.select{|x| x.stage == 'quarterfinal'}.map(&:score).compact.sum
			s = part.teams.select{|x| x.stage == 'semifinal'}.map(&:score).compact.sum
			f = part.teams.select{|x| x.stage == 'finale'}.map(&:score).compact.sum
			w = part.teams.select{|x| x.stage == 'winner'}.map(&:score).compact.sum
			
			r = part.teams.select{|x| x.stage == 'redcard'}.map(&:score).compact.sum
			tp = part.players.select{|x| x.stage == 'topplayer'}.map(&:score).compact.sum
			ts = part.players.select{|x| x.stage == 'topscorer'}.map(&:score).compact.sum

			arr << [print_rank, part.name, g,pr, pb,e,q,s,f,w, r,tp, ts, score ]

			prev = score

		end


		pdf.table( arr, :column_widths => [50,100,25,25,25,25,25, 25, 25,25,25, 25, 25, 30], :cell_style=>cellstyle )  do
			# row(0).style :rotate => 90, :height=> 100, :valign => :bottom
		end


	end

	private
	
	def start_new_page?(lines,hight)
		 (lines.size * 12 + 15 ) > h.to_i-20 #(lines-size + line-header) is too big for page with footer...
	end					
end
