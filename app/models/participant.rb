class Participant < ApplicationRecord
	has_many :games, class_name: "Bet::Game", inverse_of: :participant
	has_many :teams, class_name: "Bet::Team", inverse_of: :participant
	has_many :players, class_name: "Bet::Player", inverse_of: :participant



	has_one :redcard, -> { redcard }, class_name: 'Bet::Team', inverse_of: :participant
	has_one :winner, -> { winner }, class_name: 'Bet::Team', inverse_of: :participant
	has_many :finalists, -> { finale }, class_name: 'Bet::Team', inverse_of: :participant
	has_many :semifinalists, -> { semifinal }, class_name: 'Bet::Team', inverse_of: :participant
	has_many :quarterfinalists, -> { quarterfinal }, class_name: 'Bet::Team', inverse_of: :participant
	has_many :eightfinalists, -> { eightfinal }, class_name: 'Bet::Team', inverse_of: :participant

	has_many :poule_scores, -> { poule_score }, class_name: 'Bet::Team', inverse_of: :participant
	has_many :poule_bonuses, -> { poule_bonus }, class_name: 'Bet::Team', inverse_of: :participant

	has_one :topplayer, -> { topplayer }, class_name: 'Bet::Player', inverse_of: :participant
	has_one :topscorer, -> { topscorer }, class_name: 'Bet::Player', inverse_of: :participant


	scope :sorted, -> {includes(games: {game: [:home, :away] }, teams: :team, players: :player).sort_by{|x| x.score_total}.reverse}

	def self.ranking
		sorted.map{|x| {x.id => x.score_total} }
	end


	def self.ranked
		includes(games: {game: [:home, :away] }, teams: :team, players: :player).group_by{|x| x.score_total}.sort.reverse.inject({}){|hsh,(pnt,a)| r=hsh.size+1; a.each{|x| hsh[x] =  [r, pnt] } ;hsh}
	end


	def score_winner
		winner&.score || 0
	end

	def score_redcard
		redcard&.score || 0
	end

	def score_games
		games.map(&:score).compact.sum
	end

	def score_finalists
		finalists.map(&:score).compact.sum
	end

	def score_finalists
		finalists.map(&:score).compact.sum
	end	

	def score_semifinalists
		semifinalists.map(&:score).compact.sum
	end

	def score_quarterfinalists
		quarterfinalists.map(&:score).compact.sum
	end

	def score_eightfinalists
		eightfinalists.map(&:score).compact.sum
	end

	def score_topplayer
		topplayer&.score || 0
	end

	def score_topscorer
		topscorer&.score || 0
	end

	def score_poule_ranking
		poule_scores.map(&:score).compact.sum
	end
	

	def score_poule_bonus
		poule_bonuses.map(&:score).compact.sum
	end

	def score_total
		( games.map(&:score) + teams.map(&:score) + players.map(&:score) ).compact.sum
	end
end
