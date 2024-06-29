class Bet::Game < ApplicationRecord
	belongs_to :participant
	belongs_to :game, class_name: "::Game", optional: true


	def home?
		home > away
	end

	def away?
		away > home
	end

	def draw?
		home == away
	end

	def exact?
		home == game.score_home and away == game.score_away
	end

	def points
		score
	end




end

