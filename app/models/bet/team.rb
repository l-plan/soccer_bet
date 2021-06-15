class Bet::Team < ApplicationRecord
	enum stage: {winner: 1, finale: 2, semifinal: 4, quarterfinal: 8, eightfinal: 16, redcard: 99}

	belongs_to :participant
	belongs_to :team

end
