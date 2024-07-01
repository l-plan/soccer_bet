class Player < ApplicationRecord

	has_many :topplayers, -> { topplayer }, class_name: "Bet::Player", inverse_of: :player
	has_many :topscorers, -> { topscorer }, class_name: "Bet::Player", inverse_of: :player


	scope :topplayer, -> {where(best: true)}
	scope :topscorer, -> {where(top: true)}

	scope :ordered, -> {order(:name)}


end
