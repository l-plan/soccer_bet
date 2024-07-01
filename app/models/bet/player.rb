class Bet::Player < ApplicationRecord
	enum stage: {topscorer: 1, topplayer: 2}
	belongs_to :participant
	belongs_to :player, class_name: "::Player", optional: true

	class << self

		def calculate_topscorer
			topscorer.joins(:player).where(:player => {:top => true}).each do |player|
				player.update_attribute(:score, 5)
			end
		end

		def reset_topscorer
			topscorer.each do |player|
				player.update_attribute(:score, nil)
			end
		end

		def calculate_topplayer
			topplayer.joins(:player).where(:player => {:best=> true}).each do |player|
				player.update_attribute(:score, 5)
			end
		end

		def reset_topplayer
			topplayer.each do |player|
				player.update_attribute(:score, nil)
			end
		end
	end

end
