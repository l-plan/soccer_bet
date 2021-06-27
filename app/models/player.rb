class Player < ApplicationRecord

	has_many :topplayers, -> { topplayer }, class_name: "Bet::Player", inverse_of: :player
	has_many :topscorers, -> { topscorer }, class_name: "Bet::Player", inverse_of: :player


	def self.topplayer
		self.find_by(best: true)
	end

	def self.topscorer
		self.find_by(top: true)
	end



	def calculate_topplayer
		topplayers.each{|x| x.update_attribute(:score, 15)}
	end

	def reset_topplayer_scores
		topplayers.each{|x| x.update_attribute(:score, nil)}
	end


	def calculate_topscorer
		topscorers.each{|x| x.update_attribute(:score, 5)}
	end

	def reset_topscorer_scores
		topscorers.each{|x| x.update_attribute(:score, nil)}
	end
end
