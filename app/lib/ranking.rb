class Ranking
	attr_accessor :participant, :poule

	def initialize(poule, id=nil)
		@participant = Participant.find(id) if id
		@poule = poule
	end


	def fifa_poule_ranking

		teams = Team.where(poule: poule).includes(:fifa_ranking, :fifa_fair_play_ranking)
		teams_ids = teams.map(&:id)

		games = Game.played.where(home_id: teams_ids, away_id: teams_ids)

		standings = []
		teams.each do |team|
			standings << {team_id: team.id, played: 0, points: 0, gf: 0, ga: 0, gd: 0, fair: team.fifa_fair_play_ranking.points, fifa: team.fifa_ranking.points }
		end


		games.each do |game|
		
			home = teams.find{|x| x.id == game.home_id}
			team = standings.find{|x| x[:team_id] == home.id}
			
			team[:points]+= 3 if game.score_home > game.score_away
			team[:points]+= 1 if game.score_home == game.score_away

			team[:played]+=1
			team[:gf]+= game.score_home
			team[:ga]+= game.score_away
			team[:gd] = team[:gf] - team[:ga]




			away = teams.find{|x| x.id == game.away_id}
			team = standings.find{|x| x[:team_id] == away.id}

			team[:points]+= 3 if game.score_away > game.score_home
			team[:points]+= 1 if game.score_away == game.score_home

			team[:played]+=1
			team[:gf]+= game.score_away
			team[:ga]+= game.score_home
			team[:gd] = team[:gf] - team[:ga]			
		end
		standings = standings.sort_by{|x| [-x[:points], -x[:gd], -x[:gf], x[:fair], -x[:fifa]]}

		5.times do
			standings.each_with_index do |stand, i|
				next if i == 0
				prev = standings[i-1]
				if stand[:points]== prev[:points]
					if game = games.find{|x| x.home_id == stand[:team_id] && x.away_id == prev[:team_id]}
						standings.insert(i-1, standings.delete_at(i) ) if game.score_home > game.score_away
					end

					if game = games.find{|x| x.away_id == stand[:team_id] && x.home_id == prev[:team_id]}
						standings.insert(i-1, standings.delete_at(i) ) if game.score_away > game.score_home
					end
				end
			end
		end


		standings = standings.each_with_index.map{|x,i| [i+1,x[:team_id], Team.find(x[:team_id]).name, x[:points],  x[:gd], x[:gf], x[:fair], x[:fifa]]}



	end

	def bet_poule_ranking

		teams = Team.where(poule: poule).includes(:fifa_ranking, :fifa_fair_play_ranking)
		teams_ids = teams.map(&:id)

		games = participant.games.played.includes(:game)#.where(home_id: teams_ids, away_id: teams_ids)

		standings = []
		teams.each do |team|
			standings << {team_id: team.id, played: 0, points: 0, gf: 0, ga: 0, gd: 0, fair: team.fifa_fair_play_ranking.points, fifa: team.fifa_ranking.points }
		end


		games.each do |game|
			next unless game.home && game.away
			home = teams.find{|x| x.id == game.game.home_id}
			if home
				team = standings.find{|x| x[:team_id] == home.id}
				
				team[:points]+= 3 if game.home > game.away
				team[:points]+= 1 if game.home == game.away

				team[:played]+=1
				team[:gf]+= game.home
				team[:ga]+= game.away
				team[:gd] = team[:gf] - team[:ga]
			end




			away = teams.find{|x| x.id == game.game.away_id}
			if away
				team = standings.find{|x| x[:team_id] == away.id}

				team[:points]+= 3 if game.away > game.home
				team[:points]+= 1 if game.away == game.home

				team[:played]+=1
				team[:gf]+= game.away
				team[:ga]+= game.home
				team[:gd] = team[:gf] - team[:ga]
			end			
		end
		standings = standings.sort_by{|x| [-x[:points], -x[:gd], -x[:gf], x[:fair], -x[:fifa]]}

		5.times do
			standings.each_with_index do |stand, i|
				next if i == 0
				prev = standings[i-1]
				if stand[:points]== prev[:points]
					if game = games.find{|x| x.game.home_id == stand[:team_id] && x.game.away_id == prev[:team_id]}
						standings.insert(i-1, standings.delete_at(i) ) if game.home > game.away
					end

					if game = games.find{|x| x.game.away_id == stand[:team_id] && x.game.home_id == prev[:team_id]}
						standings.insert(i-1, standings.delete_at(i) ) if game.away > game.home
					end
				end
			end
		end


		standings = standings.each_with_index.map{|x,i| [i+1, x[:team_id], Team.find(x[:team_id]).name,x[:played], x[:points],  x[:gd], x[:gf], x[:fair], x[:fifa]]}



	end

end

