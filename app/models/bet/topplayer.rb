class Bet::Topplayer < ApplicationRecord
	belongs_to :participant
	has_one :player
end
