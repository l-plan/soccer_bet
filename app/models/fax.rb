class Fax < ApplicationRecord

	enum :stage, {winner: 6, finale: 5, semifinal: 4, quarterfinal: 3, eightfinal: 2, pool: 0, redcard: 99, poule_score: 77, poule_bonus: 88, sixteenfinal: 1, goals: 98}
	enum :error, {"double entry": 1, "not found": 2, "no entry": 3}

	belongs_to :participant
end
