class Bet::Game < ApplicationRecord
	belongs_to :participant
	belongs_to :game
end
