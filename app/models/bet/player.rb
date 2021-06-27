class Bet::Player < ApplicationRecord
	enum stage: {topscorer: 1, topplayer: 2}
	belongs_to :participant
	belongs_to :player, class_name: "::Player", optional: true
end
