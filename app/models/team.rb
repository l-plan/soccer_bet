class Team < ApplicationRecord

	has_many :winners, -> { winner }, class_name: "Bet::Team", inverse_of: :team
	has_many :redcards, -> { redcard }, class_name: "Bet::Team", inverse_of: :team

	has_many :finalists, -> { finale }, class_name: 'Bet::Team', inverse_of: :team
	has_many :semifinalists, -> { semifinal }, class_name: 'Bet::Team', inverse_of: :team
	has_many :quarterfinalists, -> { quarterfinal }, class_name: 'Bet::Team', inverse_of: :team
	has_many :eightfinalists, -> { eightfinal }, class_name: 'Bet::Team', inverse_of: :team
	has_many :sixteenfinalists, -> { sixteenfinal }, class_name: 'Bet::Team', inverse_of: :team

	has_many :poule_scores, -> { poule_score }, class_name: 'Bet::Team', inverse_of: :team

	has_one :fifa_ranking, class_name: "Fifa::Ranking"
	has_one :fifa_fair_play_ranking, class_name: "Fifa::FairPlayRanking"





	scope :sixteenfinalists, -> {where(fin32: true)}
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

	def self.calculate_poule_rank
		%w(a b c d e f g h i j k l).each do |poule|
			Ranking.new(poule).fifa_poule_ranking.each do |rank|
				self.find(rank[1]).update_attribute(:poule_rank, rank[0])
			end
		end
	end

	

	def self.reset_poule_rank
		unscoped.each{|x| x.update_attribute(:poule_rank, nil)}
	end



end
