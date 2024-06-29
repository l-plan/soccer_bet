class Bet::Team < ApplicationRecord
	enum stage: {winner: 6, finale: 5, semifinal: 4, quarterfinal: 3, eightfinal: 2, pool: 1, redcard: 99, poule_score: 77, poule_bonus: 88}

	belongs_to :participant
	belongs_to :team, class_name: "::Team", optional: true

	scope :bonus, -> (poule){where(stage: :poule_bonus, poule: poule)}
	scope :knockout, -> {where(stage: [:finale, :semifinal, :quarterfinal, :eightfinal])}
	scope :pouleranking, -> {where(stage: [:poule_score, :poule_bonus])}

	# has_many :poule_teams, ::Team.where(poule: poule)






	class << self

		def reset_poule_bonus
			poule_bonus.each{|x| x.update_attribute(:score, 0)}
		end


		def calculate_poule_bonus
			poule_score.group_by{|x| [x.participant_id, x.poule]}.each do |k,v|

				sum = v.collect(&:score).compact.sum
				next unless sum==4
				Bet::Team.find_by(participant_id: k[0], poule: k[1]).update_attribute(:score, 2)
			end
		end

		def reset_poule_rank_score
			poule_score.each{|x| x.update_attribute(:score, 0)}
		end


		def calculate_poule_rank_score
			poule_score.each{|x| x.update_attribute(:score, 1) if x.team.poule_rank == x.poule_rank}
		end

	end



end
