class Bet::Goal < ApplicationRecord
	belongs_to :participant, inverse_of: :goal
end