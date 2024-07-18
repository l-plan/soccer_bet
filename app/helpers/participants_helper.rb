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


	def games_array(participant)
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

	end

	def poule_ranking_array(participant)
		arr = [["poule-rankings", nil, nil, nil]]
		# eigthfinalists = participant.teams.select{|x| x.stage=="eightfinal"}.sort_by{|x| x.team.name}
		poule_ranking = participant.teams.select{|x| x.stage=="poule_score"}.group_by{|x| x.team.poule}

		poule_ranking.each do |k,v|
			arr << [k,nil,nil,nil]
			v.sort_by{|x| x.team.poule_rank}.each do |team|
				arr << [team.team.name, team.team.poule_rank.to_s, "(#{team.poule_rank})", team.score.to_s]
			end
			arr << ['bonus', nil, nil,participant.teams.select{|x| x.stage=="poule_bonus" and x.poule == k }[0].score.to_s]
		end





		arr << ['totaal score ranking', nil,nil ,participant.teams.select{|x| x.stage=='poule_score' or x.stage=='poule_bonus'}.map(&:score).compact.sum]
		
	end

	def eigthfinalists_array(participant)
		arr = []
		eigthfinalists = participant.teams.select{|x| x.stage=="eightfinal"}
		unless eigthfinalists.empty?
			eigthfinalists.sort_by{|x| x.team&.name}


			eigthfinalists.each do |team|
				arr << [nil, team.team.name, team.score.to_s]
			end
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
		arr[0][0] = "quarterfinal"
		arr << [nil, nil,quarterfinalists.map(&:score).compact.sum]

	end

	def semifinalists_array(participant)
		arr = []
		semifinalists = participant.teams.select{|x| x.stage=="semifinal"}.sort_by{|x| x.team.name}

		semifinalists.each do |team|
			arr << [nil, team.team.name, team.score.to_s]
		end
		arr[0][0] = "semifinal"
		arr << [nil, nil,semifinalists.map(&:score).compact.sum]

	end

	def finalists_array(participant)
		arr = []
		finalists = participant.teams.select{|x| x.stage=="finale"}.sort_by{|x| x.team.name}

		finalists.each do |team|
			arr << [nil, team.team.name, team.score.to_s]
		end
		arr[0][0] = "finale"

		arr << [nil, nil,finalists.map(&:score).compact.sum]
		
	end


	def winner_array(participant)
		arr = []
		winner = participant.teams.find{|x| x.stage=="winner"}
		arr << ["winner",winner.team.name, winner.score.to_s]

	end

	def topplayer_array(participant)
		arr = []
		player = participant.players.find{|x| x.stage=="topplayer"}
		arr << ["topplayer",player.player.name, player.score.to_s]

	end

	def topscorer_array(participant)
		arr = []
		player = participant.players.find{|x| x.stage=="topscorer"}
		arr << ["topscorer",player.player.name, player.score.to_s]

	end

	def redcard_array(participant)
		arr = []
		team = participant.teams.find{|x| x.stage=="redcard"}
		arr << ["redcard",team&.team&.name, team&.score&.to_s]

	end

	def score_array(participant)
		arr = []

		arr << ["totaal",nil, participant.score_total.to_s]

	end
end