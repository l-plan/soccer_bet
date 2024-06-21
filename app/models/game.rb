class Game < ApplicationRecord
	enum stage: {winner: 6, finale: 5, semifinal: 4, quarterfinal: 3, eightfinal: 2, pool: 1, redcard: 99}
	belongs_to :home, class_name: "Team", optional: true
	belongs_to :away, class_name: "Team", optional: true
	has_many :games, class_name: "Bet::Game"

	# has_many :teams, class_name: "Bet::Team",
	# has_many :teams, -> { Bet::Team.where(stage: "eightfinal", team_id: [1,2]) }


	def teams
		Bet::Team.where(stage: stage, team_id: [home&.id, away&.id])
	end

	def calculate
		send("calculate_#{stage}")
	end

	def reset_scores
		send("reset_scores_#{stage}")
	end

	def calculate_pool
		return unless score_home and score_away
		games.each do |game|
			p = 0
			if home? and game.home?
				p = 1
			end

			if away? and game.away?
				p = 1
			end


			if draw? and game.draw?
				p = 1
			end

			if game.exact?
				p+=2
			end

			game.update_attribute(:score, p)
		end
	end

	def self.calculate_stage_scores(stage)
		if stage == "pool"
			self.calculate_pool_scores
		else
			self.calculate_team_scores(stage)
		end		
	end

	def self.reset_stage_scores(stage)
		if stage == "pool"
			self.reset_scores_pool
		else
			self.reset_scores_teams(stage)
		end
	end


	def self.calculate_pool_scores
		self.pool.each do |game|
			game.calculate_pool
		end
	end

	def self.calculate_team_scores(stage)
		self.send(stage).each do |game|
			game.send("calculate_#{stage}")
		end
	end

	def self.reset_scores_pool
		self.pool.each do |game|
			game.reset_scores_pool
		end

	end

	def self.reset_scores_teams(stage)
		self.send(stage).each do |game|
			game.send("reset_scores_#{stage}")
		end		
	end

	def self.stage_scores(stage)
		if stage == "pool"
			Bet::Game.all.map(&:score).compact.sum
		else
			Bet::Team.send(stage).map(&:score).compact.sum
		end
	end

	def reset_scores_pool
		games.each{|x| x.update_attribute(:score, nil)}
	end

	def calculate_eightfinal
		teams.each do |team|
			team.update_attribute(:score, 2)
		end
	end

	def reset_scores_eightfinal
		teams.each do |team|
			team.update_attribute(:score, nil)
		end
	end

	def calculate_quarterfinal
		teams.each do |team|

			team.update_attribute(:score, 4) if team.team_id
		end
	end

	def reset_scores_quarterfinal
		teams.each do |team|
			team.update_attribute(:score, nil)
		end
	end


	def calculate_semifinal
		teams.each do |team|
			team.update_attribute(:score, 6)
		end
	end

	def reset_scores_semifinal
		teams.each do |team|
			team.update_attribute(:score, nil)
		end
	end


	def calculate_finale
		teams.each do |team|
			team.update_attribute(:score, 8)
		end
	end

	def reset_scores_finale
		teams.each do |team|
			team.update_attribute(:score, nil)
		end
	end


	# def calculate_winner
	# 	teams.each do |team|
	# 		team.update_attribute(:score, nil)
	# 	end
	# end

	# def reset_scores_winner
	# 	teams.each do |team|
	# 		team.update_attribute(:score, nil)
	# 	end
	# end

	def home?
		return unless score_home and score_away
		score_home > score_away
	end

	def away?
		return unless score_home and score_away
		score_away > score_home
	end

	def draw?
		return unless score_home and score_away
		score_home == score_away
	end

	def score
		
		if stage == "pool"
			return unless (home_id and away_id)
			games.map(&:score).compact.sum
		else
			return unless (home_id or away_id)
			teams.map(&:score).compact.sum
		end

	end

end


# Puntentelling	
	
# - Heb je de toto uitslag van een groepswedstrijd goed dan verdien je 3 punten.	
# Is de uitslag helemaal juist dan verdien je 5 punten	
	
# - Voor elke goed voorspelde ploeg in de 8e finale verdien je 2 punten	
	
# - Voor elke goed voorspelde ploeg in de 4e finale verdien je 4 punten	
	
# - Voor elke goed voorspelde ploeg in de halve finale verdien je 6 punten	
	
# - Voor elke goed voorspelde ploeg in de finale verdien je 8 punten	
	
# - Voorspel je de winnaar goed dan verdien je 15 punten	
	
# - Voor elke juist beantwoorde bonusvraag verdien je 5 punten	