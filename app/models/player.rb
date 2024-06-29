class Player < ApplicationRecord

	has_many :topplayers, -> { topplayer }, class_name: "Bet::Player", inverse_of: :player
	has_many :topscorers, -> { topscorer }, class_name: "Bet::Player", inverse_of: :player


	scope :topplayer, -> {where(best: true)}
	scope :topscorer, -> {where(top: true)}


	class << self

		def calculate_topplayer
			topplayer.each do |player|
				player.topplayers.each{|x| x.update_attribute(:score, 5)}
			end
		end

		def reset_topplayer
			Bet::Player.topplayer.each{|x| x.update_attribute(:score, nil)}
		end

		def calculate_topscorer
			topscorer.each do |player|
				player.topscorers.each{|x| x.update_attribute(:score, 5)}
			end
		end

		def reset_topscorer
			Bet::Player.topscorer.each{|x| x.update_attribute(:score, nil)}
		end

	end
end
