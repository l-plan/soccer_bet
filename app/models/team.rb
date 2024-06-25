class Team < ApplicationRecord

	has_many :winners, -> { winner }, class_name: "Bet::Team", inverse_of: :team
	has_many :redcards, -> { redcard }, class_name: "Bet::Team", inverse_of: :team

	has_many :finalists, -> { finale }, class_name: 'Bet::Team', inverse_of: :team
	has_many :semifinalists, -> { semifinal }, class_name: 'Bet::Team', inverse_of: :team
	has_many :quarterfinalists, -> { quarterfinal }, class_name: 'Bet::Team', inverse_of: :team
	has_many :eightfinalists, -> { eightfinal }, class_name: 'Bet::Team', inverse_of: :team





	def self.winner
		Team.find_by(winner: true)
	end

	def self.redcard
		Team.find_by(red: true)
	end



	def calculate_winner
		winners.each{|x| x.update_attribute(:score, 15)}
	end

	def reset_winner_scores
		winners.each{|x| x.update_attribute(:score, nil)}
	end


	def calculate_redcard
		redcards.each{|x| x.update_attribute(:score, 5)}
	end

	def reset_redcard_scores
		redcards.each{|x| x.update_attribute(:score, nil)}
	end

	def calculate_poule_rank_score
	end

end
