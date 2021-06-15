class Bet::Topscorer < ApplicationRecord
	belongs_to :participant
	has_one :player
end
