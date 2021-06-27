module PrintParticipantHelper


	def print_participant_page(participant)
		print_participant_header(participant)

		print_games(participant)

		h -601

		print_eigthfinalists(participant)

		print_quarterfinalists(participant)

		print_semifinalists(participant)

		print_finalists(participant)

		print_winner(participant)

		print_topplayer(participant)

		print_topscorer(participant)

		print_redcard(participant)

		h 50

		print_score(participant)
	end

	def print_participant_header(participant)

		arr = []
		arr << ["bijgewerkt op", "#{printed_on}"]
		arr << [ 'rank' ,rank.to_s]
		arr << [ 'naam' ,participant.name]
		arr << [ 'email',participant.email]

		pdf.table( arr, :column_widths => [100, 125], :cell_style=>cellstyle , position: 0) do
			column(1).style :align => :right 
		end

		h 20

	end


	def print_games(participant)
		arr = []

		poule = %w(A B C D E F )
		participant.games.each_slice(6).with_index do |games, i|
			arr << ["poule #{poule[i]}"]
			games.each do |game|

				
				arr<< [game.game.home.name, '-', game.game.away.name, nil, "#{game.home} - #{game.away}",nil, "(#{game.game.score_home} - #{game.game.score_away})", game.score.to_s]
			end
		end
		arr << [nil,nil,nil, nil,nil,nil,nil,participant.games.map(&:score).compact.sum]

		pdf.table( arr, :column_widths => [60,10,60,10, 25, 10, 25, 25], :cell_style=>cellstyle , position: 0) do
			column(7).style :align => :right
			rows([0,7,14,21,28,35,42]).style :font_style=> :bold	
		end

	end

	def print_eigthfinalists(participant)
		arr = []
		
		participant.teams.eightfinal.sort_by{|x| x.team.name}.each do |team|
			arr << [nil, team.team.name, team.score.to_s]
		end
		arr[0][0] = "eightfinal"

		arr << [nil, nil,participant.teams.eightfinal.map(&:score).compact.sum]
		
		pdf.table( arr, :column_widths => [80, 80, 25], :cell_style=>cellstyle , position: 300) do
			column(2).style :align => :right
			column(0).style :font_style=> :bold
			row(-1).style :font_style=> :bold


		end

	end

	def print_quarterfinalists(participant)
		arr = []

		participant.teams.quarterfinal.sort_by{|x| x.team.name}.each do |team|
			arr << [nil, team.team.name, team.score.to_s]
		end
		arr[0][0] = "quarterfinal"
		arr << [nil, nil,participant.teams.quarterfinal.map(&:score).compact.sum]
		h 10
		pdf.table( arr, :column_widths => [80, 80, 25], :cell_style=>cellstyle , position: 300) do
			column(2).style :align => :right
			column(0).style :font_style=> :bold
			row(-1).style :font_style=> :bold
		end

	end

	def print_semifinalists(participant)
		arr = []

		participant.teams.semifinal.sort_by{|x| x.team.name}.each do |team|
			arr << [nil, team.team.name, team.score.to_s]
		end
		arr[0][0] = "semifinal"
		arr << [nil, nil,participant.teams.semifinal.map(&:score).compact.sum]
		h 10
		pdf.table( arr, :column_widths => [80, 80, 25], :cell_style=>cellstyle , position: 300) do
			column(2).style :align => :right
			column(0).style :font_style=> :bold	
			row(-1).style :font_style=> :bold
		end

	end

	def print_finalists(participant)
		arr = []

		participant.teams.finale.sort_by{|x| x.team.name}.each do |team|
			arr << [nil, team.team.name, team.score.to_s]
		end
		arr[0][0] = "finale"

		arr << [nil, nil,participant.teams.finale.map(&:score).compact.sum]
		h 10
		pdf.table( arr, :column_widths => [80, 80, 25], :cell_style=>cellstyle , position: 300) do
			column(2).style :align => :right
			column(0).style :font_style=> :bold
			row(-1).style :font_style=> :bold
		end

	end


	def print_winner(participant)
		arr = []

		arr << ["winner",participant.winner.team.name, participant.winner.score.to_s]
		pdf.table( arr, :column_widths => [80, 80, 25], :cell_style=>cellstyle , position: 300) do
			column(2).style :align => :right
			column(0).style :font_style=> :bold	
		end

	end

	def print_topplayer(participant)
		arr = []

		arr << ["topplayer",participant.topplayer.player.name, participant.topplayer.score.to_s]
		pdf.table( arr, :column_widths => [80, 80, 25], :cell_style=>cellstyle , position: 300) do
			column(2).style :align => :right
			column(0).style :font_style=> :bold	
		end
	end

	def print_topscorer(participant)
		arr = []

		arr << ["topscorer",participant.topscorer.player.name, participant.topscorer.score.to_s]
		pdf.table( arr, :column_widths => [80, 80, 25], :cell_style=>cellstyle , position: 300) do
			column(2).style :align => :right
			column(0).style :font_style=> :bold	
		end
	end

	def print_redcard(participant)
		arr = []

		arr << ["redcard",participant.redcard.team.name, participant.redcard.score.to_s]
		pdf.table( arr, :column_widths => [80, 80, 25], :cell_style=>cellstyle , position: 300) do
			column(2).style :align => :right
			column(0).style :font_style=> :bold	
		end
	end

	def print_score(participant)
		arr = []

		arr << ["totaal",nil, participant.score_total.to_s]
		pdf.table( arr, :column_widths => [80, 80, 25], :cell_style=>cellstyle , position: 300) do
			column(2).style :align => :right
			row(0).style :font_style=> :bold	
		end	
	end
end