class Bet::Game < ApplicationRecord
	belongs_to :participant
	belongs_to :game, class_name: "::Game", optional: true

	scope :pool, -> {unscoped}
	scope :updated, -> {unscoped}


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





	class << self


		def calculate_pool
			Bet::Game.joins(:game).where.not(:game =>{score_home: nil, score_away: nil} ).each do |game|
				p = 0
				if game.home? and game.game.home?
					p = 1
				end

				if game.away? and game.game.away?
					p = 1
				end


				if game.draw? and game.game.draw?
					p = 1
				end

				if game.exact?
					p+=2
				end

				game.update_attribute(:score, p)

			end

		end

		def reset_pool
			unscoped.each{|x| x.update_attribute(:score, nil)}
		end
	end




end

