class Team < ApplicationRecord

	has_many :winners, -> { winner }, class_name: "Bet::Team", inverse_of: :team
	has_many :redcards, -> { redcard }, class_name: "Bet::Team", inverse_of: :team

	has_many :finalists, -> { finale }, class_name: 'Bet::Team', inverse_of: :team
	has_many :semifinalists, -> { semifinal }, class_name: 'Bet::Team', inverse_of: :team
	has_many :quarterfinalists, -> { quarterfinal }, class_name: 'Bet::Team', inverse_of: :team
	has_many :eightfinalists, -> { eightfinal }, class_name: 'Bet::Team', inverse_of: :team

	has_many :poule_scores, -> { poule_score }, class_name: 'Bet::Team', inverse_of: :team




	scope :eightfinalists, -> {where(fin16: true)}
	scope :quarterfinalists, -> {where(fin8: true)}
	scope :semifinalists, -> {where(fin4: true)}
	scope :finalists, -> {where(fin2: true)}
	

	scope :winners, -> {where(winner: true)}
	scope :redcards, -> {where(red: true)}



	def self.winner
		Team.find_by(winner: true)
	end

	def self.redcard
		Team.find_by(red: true)
	end




end
