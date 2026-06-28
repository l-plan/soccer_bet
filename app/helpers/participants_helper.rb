module ParticipantsHelper


	def print_participant_page(participant)
		print_participant_header(participant)

		h 20

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

	def participant_header_array(participant)

		arr = []
		arr << ["bijgewerkt op", "#{printed_on}", "<color rgb='0000FF'><u><link href='/participants/#{participant.id}/download'>download</link></u></color>", "<color rgb='0000FF'><u><link href='/participants/#{participant.id}'>close pdf</link></u></color>"]
		arr << [ 'rank' ,rank.to_s]
		arr << [ 'naam' ,participant.name]
		arr << [ 'email',participant.email]
		arr


	end

	def final_scores_array(participant)
		arr = []
		arr << ["poulefase", participant.games.map(&:score).compact.sum,nil, "16e finale", participant.teams.sixteenfinal.map(&:score).compact.sum, nil, "winnaar", participant.teams.winner.map(&:score).compact.sum ]
		arr << ["eindstand poules", participant.teams.pouleranking.map(&:score).compact.sum, nil,"8e finale", participant.teams.eightfinal.map(&:score).compact.sum, nil, "rode kaart", participant.teams.redcard.map(&:score).compact.sum ]


		arr << [nil, nil, nil,"kwart finale", participant.teams.quarterfinal.map(&:score).compact.sum, nil, "topplayer",participant.players.topplayer.map(&:score).compact.sum]
		arr << [nil, nil,nil,"halve finale", participant.teams.semifinal.map(&:score).compact.sum, nil, "topscorer",participant.players.topscorer.map(&:score).compact.sum]
		arr << [nil, nil,nil,"finale", participant.teams.finale.map(&:score).compact.sum]
		arr << ["totaal", nil, nil, nil, nil, nil, nil, participant.score_total]



	end


	def games_array(participant)
		arr = []
		gamez = participant.games

		poule = %w(A B C D E F G H I J K L)
		gamez.each_slice(6).with_index do |games, i|
			arr << ["poule #{poule[i]}"]
			games.each do |game|

				
				arr<< [game.game.home.name, '-', game.game.away.name, nil, "#{game.home} - #{game.away}",nil, "(#{game.game.score_home} - #{game.game.score_away})", game.score.to_s]
			end
		end
		arr << [nil,nil,nil, nil,nil,nil,nil, gamez.map(&:score).compact.sum]

	end

	def poule_ranking_array(participant)


		arr = [["poule-rankings", nil, nil, nil]]
		# eigthfinalists = participant.teams.select{|x| x.stage=="eightfinal"}.sort_by{|x| x.team.name}
		poule_ranking = participant.teams.poule_score.group_by{|x| x.poule}

		poule_ranking.each do |k,v|
			arr << [nil,k,nil,nil]
			v.sort_by{|x| x.poule_rank}.each do |team|
				arr << [team.poule_rank.to_s, team.team.name, team.team.poule_rank.to_s, team.score.to_s]
			end

			arr << ['bonus', nil, nil,participant.teams.find{|x| x.stage=="poule_bonus" and x.poule.in? ([k, k.downcase, k.upcase].uniq) }&.score.to_s]
		end
		arr = []

		participant.teams.poule_score.group_by(&:poule).each_slice(2).map{|x| x}.each do |a,b|

			left  = a[1].sort_by(&:poule_rank)
			right = b[1].sort_by(&:poule_rank)

			line = Array.new(9)

			line.insert( 0, a[0].upcase )
			line.insert( 5, b[0].upcase )
			arr << line

				left_score = 0
				right_score = 0


			(0..3).each do |i|

				line = Array.new(9)
				line[0]= left[i].poule_rank.to_s
				line[1]= left[i].team.name
				line[2]= "( #{left[i].team.poule_rank} )"

				score = left[i].score 
				left_score+= score if score
				line[3]= score.to_s

				line[5]= right[i].poule_rank.to_s
				line[6]= right[i].team.name
				line[7]= "( #{right[i].team.poule_rank} )"

				score = right[i].score 
				right_score+= score	if score	
				line[8]= score.to_s

				arr << line
			end

			line = Array.new(9)
			score = participant.teams.poule_bonus.find{|x| x.poule == a[0]}&.score
			left_score += score if score
			line[1] = 'bonus'
			line[3] = score.to_s

			score = participant.teams.poule_bonus.find{|x| x.poule == b[0]}&.score
			right_score += score if score
			line[6] = 'bonus'
			line[8] = score.to_s

			arr << line

			line = Array.new(9)
			line[1] = "totaal poule #{a[0]}"
			line[3] = left_score.to_s
			line[6] = "totaal poule #{b[0]}"
			line[8] = right_score.to_s

			arr << line

		end

		arr 

		line = Array.new(9)
		line[1] = 'totaal score ranking'
		line[8] = participant.teams.select{|x| x.stage=='poule_score' or x.stage=='poule_bonus'}.map(&:score).compact.sum

		# arr << ['totaal score ranking', nil,nil ,participant.teams.select{|x| x.stage=='poule_score' or x.stage=='poule_bonus'}.map(&:score).compact.sum]
		arr << line
	end

	def goals_array(participant)
		arr = []
		amount = participant.goal&.amount

		if amount
			arr << ["goals",amount, '']
		else
			arr << ["goals",'', '']
		end		
	end


	def sixteenfinalists_array(participant)
		arr = []
		sixteenfinalists = participant.teams.select{|x| x.stage=="sixteenfinal"}


		unless sixteenfinalists.empty?


			sixteenfinalists.sort_by{|x| x.team&.name}


			sixteenfinalists.each do |team|
				arr << [nil, team.team.name, team.score.to_s]
			end
		else
			arr << []
		end

		arr[0][0] = "sixteenfinal"

		arr << [nil, nil,sixteenfinalists.map(&:score).compact.sum]
		
	end

	def eigthfinalists_array(participant)
		arr = []
		eigthfinalists = participant.teams.select{|x| x.stage=="eightfinal"}


		unless eigthfinalists.empty?


			eigthfinalists.sort_by{|x| x.team&.name}


			eigthfinalists.each do |team|
				arr << [nil, team.team.name, team.score.to_s]
			end
		else
			arr << []
		end

		arr[0][0] = "eightfinal"

		arr << [nil, nil,eigthfinalists.map(&:score).compact.sum]
		
	end

	def quarterfinalists_array(participant)
		arr = []
		quarterfinalists =  participant.teams.select{|x| x.stage=="quarterfinal"}.sort_by{|x| x.team&.name||""}

		quarterfinalists.each do |team|
			arr << [nil, team.team&.name|| "", team.score.to_s]
		end
		arr << [] if arr.empty?
		arr[0][0] = "quarterfinal"
		arr << [nil, nil,quarterfinalists.map(&:score).compact.sum]

	end

	def semifinalists_array(participant)
		arr = []
		semifinalists = participant.teams.select{|x| x.stage=="semifinal"}.sort_by{|x| x.team.name}

		semifinalists.each do |team|
			arr << [nil, team.team.name, team.score.to_s]
		end
		arr << [] if arr.empty?
		arr[0][0] = "semifinal"
		arr << [nil, nil,semifinalists.map(&:score).compact.sum]

	end

	def finalists_array(participant)
		arr = []
		finalists = participant.teams.select{|x| x.stage=="finale"}.sort_by{|x| x.team.name}

		finalists.each do |team|
			arr << [nil, team.team.name, team.score.to_s]
		end
		arr << [] if arr.empty?
		arr[0][0] = "finale"

		arr << [nil, nil,finalists.map(&:score).compact.sum]
		
	end


	def winner_array(participant)
		arr = []
		winner = participant.teams.find{|x| x.stage=="winner"}

		if winner
			arr << ["winner",winner.team.name, winner.score.to_s]
		else
			arr << ["winner",'', '']
		end

	end

	def topplayer_array(participant)
		arr = []
		player = participant.players.find{|x| x.stage=="topplayer"}
		if player
			arr << ["topplayer",player.player.name, player.score.to_s]
		else
			arr << ["topplayer",'', '']
		end

	end

	def topscorer_array(participant)

		arr = []
		player = participant.players.find{|x| x.stage=="topscorer"}

		if player
			arr << ["topscorer",player.player.name, player.score.to_s]
		else
			arr << ["topscorer",'', '']
		end

	end

	def redcard_array(participant)
		arr = []
		team = participant.teams.find{|x| x.stage=="redcard"}
		if team
			arr << ["redcard",team&.team&.name, team&.score&.to_s]

		else
			arr << ["redcard",'', '']
		end

	end

	def score_array(participant)
		arr = []

		arr << ["totaal",nil, participant.score_total.to_s]

	end
end