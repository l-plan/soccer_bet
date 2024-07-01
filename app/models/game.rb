class Game < ApplicationRecord
	enum stage: {winner: 6, finale: 5, semifinal: 4, quarterfinal: 3, eightfinal: 2, pool: 1, redcard: 99}
	belongs_to :home, class_name: "Team", optional: true
	belongs_to :away, class_name: "Team", optional: true
	has_many :games, class_name: "Bet::Game"


	scope :played, -> {includes(:games).where.not(score_home: nil, score_away: nil) }

	def teams
		Bet::Team.where(stage: stage, team_id: [home&.id, away&.id])
	end



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


# Puntentelling	2022
	
# - Heb je de toto uitslag van een groepswedstrijd goed dan verdien je 3 punten.	
# Is de uitslag helemaal juist dan verdien je 5 punten	
	
# - Voor elke goed voorspelde ploeg in de 8e finale verdien je 2 punten	
	
# - Voor elke goed voorspelde ploeg in de 4e finale verdien je 4 punten	
	
# - Voor elke goed voorspelde ploeg in de halve finale verdien je 6 punten	
	
# - Voor elke goed voorspelde ploeg in de finale verdien je 8 punten	
	
# - Voorspel je de winnaar goed dan verdien je 15 punten	
	
# - Voor elke juist beantwoorde bonusvraag verdien je 5 punten	