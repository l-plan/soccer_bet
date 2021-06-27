class Bet::Team < ApplicationRecord
	enum stage: {winner: 6, finale: 5, semifinal: 4, quarterfinal: 3, eightfinal: 2, pool: 1, redcard: 99}

	belongs_to :participant
	belongs_to :team, class_name: "::Team", optional: true

end
