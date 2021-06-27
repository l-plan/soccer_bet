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
		gamez = participant.games

		poule = %w(A B C D E F )
		gamez.each_slice(6).with_index do |games, i|
			arr << ["poule #{poule[i]}"]
			games.each do |game|

				
				arr<< [game.game.home.name, '-', game.game.away.name, nil, "#{game.home} - #{game.away}",nil, "(#{game.game.score_home} - #{game.game.score_away})", game.score.to_s]
			end
		end
		arr << [nil,nil,nil, nil,nil,nil,nil, gamez.map(&:score).compact.sum]

		pdf.table( arr, :column_widths => [60,10,60,10, 25, 10, 25, 25], :cell_style=>cellstyle , position: 0) do
			column(7).style :align => :right
			rows([0,7,14,21,28,35,42]).style :font_style=> :bold	
		end

	end

	def print_eigthfinalists(participant)
		arr = []
		eigthfinalists = participant.teams.select{|x| x.stage=="eightfinal"}.sort_by{|x| x.team.name}


		eigthfinalists.each do |team|
			arr << [nil, team.team.name, team.score.to_s]
		end
		arr[0][0] = "eightfinal"

		arr << [nil, nil,eigthfinalists.map(&:score).compact.sum]
		
		pdf.table( arr, :column_widths => [80, 80, 25], :cell_style=>cellstyle , position: 300) do
			column(2).style :align => :right
			column(0).style :font_style=> :bold
			row(-1).style :font_style=> :bold


		end

	end

	def print_quarterfinalists(participant)
		arr = []
		quarterfinalists =  participant.teams.select{|x| x.stage=="quarterfinal"}.sort_by{|x| x.team&.name||""}

		quarterfinalists.each do |team|
			arr << [nil, team.team&.name|| "", team.score.to_s]
		end
		arr[0][0] = "quarterfinal"
		arr << [nil, nil,quarterfinalists.map(&:score).compact.sum]
		h 10
		pdf.table( arr, :column_widths => [80, 80, 25], :cell_style=>cellstyle , position: 300) do
			column(2).style :align => :right
			column(0).style :font_style=> :bold
			row(-1).style :font_style=> :bold
		end

	end

	def print_semifinalists(participant)
		arr = []
		semifinalists = participant.teams.select{|x| x.stage=="semifinal"}.sort_by{|x| x.team.name}

		semifinalists.each do |team|
			arr << [nil, team.team.name, team.score.to_s]
		end
		arr[0][0] = "semifinal"
		arr << [nil, nil,semifinalists.map(&:score).compact.sum]
		h 10
		pdf.table( arr, :column_widths => [80, 80, 25], :cell_style=>cellstyle , position: 300) do
			column(2).style :align => :right
			column(0).style :font_style=> :bold	
			row(-1).style :font_style=> :bold
		end

	end

	def print_finalists(participant)
		arr = []
		finalists = participant.teams.select{|x| x.stage=="finale"}.sort_by{|x| x.team.name}

		finalists.each do |team|
			arr << [nil, team.team.name, team.score.to_s]
		end
		arr[0][0] = "finale"

		arr << [nil, nil,finalists.map(&:score).compact.sum]
		h 10
		pdf.table( arr, :column_widths => [80, 80, 25], :cell_style=>cellstyle , position: 300) do
			column(2).style :align => :right
			column(0).style :font_style=> :bold
			row(-1).style :font_style=> :bold
		end

	end


	def print_winner(participant)
		arr = []
		winner = participant.teams.find{|x| x.stage=="winner"}
		arr << ["winner",winner.team.name, winner.score.to_s]

		pdf.table( arr, :column_widths => [80, 80, 25], :cell_style=>cellstyle , position: 300) do
			column(2).style :align => :right
			column(0).style :font_style=> :bold	
		end

	end

	def print_topplayer(participant)
		arr = []
		player = participant.players.find{|x| x.stage=="topplayer"}
		arr << ["topplayer",player.player.name, player.score.to_s]

		pdf.table( arr, :column_widths => [80, 80, 25], :cell_style=>cellstyle , position: 300) do
			column(2).style :align => :right
			column(0).style :font_style=> :bold	
		end
	end

	def print_topscorer(participant)
		arr = []
		player = participant.players.find{|x| x.stage=="topscorer"}
		arr << ["topscorer",player.player.name, player.score.to_s]

		pdf.table( arr, :column_widths => [80, 80, 25], :cell_style=>cellstyle , position: 300) do
			column(2).style :align => :right
			column(0).style :font_style=> :bold	
		end
	end

	def print_redcard(participant)
		arr = []
		team = participant.teams.find{|x| x.stage=="redcard"}
		arr << ["redcard",team.team.name, team.score.to_s]

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