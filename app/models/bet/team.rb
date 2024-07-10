class Bet::Team < ApplicationRecord
	enum stage: {winner: 6, finale: 5, semifinal: 4, quarterfinal: 3, eightfinal: 2, pool: 1, redcard: 99, poule_score: 77, poule_bonus: 88}

	belongs_to :participant
	belongs_to :team, class_name: "::Team", optional: true

	scope :bonus, -> (poule){where(stage: :poule_bonus, poule: poule)}
	scope :knockout, -> {where(stage: [:finale, :semifinal, :quarterfinal, :eightfinal])}
	scope :pouleranking, -> {where(stage: [:poule_score, :poule_bonus])}

	scope :updated, ->(stage){where(stage: stage).order(:updated_at)}



	class << self

		def calculate_poule_score
			poule_score.each{|x| x.update_attribute(:score, 1) if x.team.poule_rank == x.poule_rank}
		end

		def reset_poule_score
			poule_score.each{|x| x.update_attribute(:score, 0)}
		end

		def calculate_poule_bonus
			poule_score.group_by{|x| [x.participant_id, x.poule]}.each do |k,v|
				sum = v.collect(&:score).compact.sum
				next unless sum==4
				Bet::Team.find_by(participant_id: k[0], poule: k[1]).update_attribute(:score, 2)
			end
		end

		def reset_poule_bonus
			poule_bonus.each{|x| x.update_attribute(:score, nil)}
		end


		def calculate_eightfinal
			eightfinal.joins(:team).where(:team => {:fin16 => true}).each do |team|
				team.update_attribute(:score, 2)
			end
		end

		def reset_eightfinal
			eightfinal.each do |team|
				team.update_attribute(:score, nil)
			end
		end

		def calculate_quarterfinal
			quarterfinal.joins(:team).where(:team => {:fin8 => true}).each do |team|
				team.update_attribute(:score, 3)
			end
		end

		def reset_quarterfinal
			quarterfinal.each do |team|
				team.update_attribute(:score, nil)
			end
		end

		def calculate_semifinal
			semifinal.joins(:team).where(:team => {:fin4 => true}).each do |team|
				team.update_attribute(:score, 5)
			end
		end

		def reset_semifinal
			semifinal.each do |team|
				team.update_attribute(:score, nil)
			end
		end

		def calculate_finale
			finale.joins(:team).where(:team => {:fin2 => true}).each do |team|
				team.update_attribute(:score, 10)
			end
		end

		def reset_final
			final.each do |team|
				team.update_attribute(:score, nil)
			end
		end


		def calculate_winner
			winner.joins(:team).where(:team => {:winner => true}).each do |team|
				team.update_attribute(:score, 25)
			end
		end

		def reset_winner
			winner.each do |team|
				team.update_attribute(:score, nil)
			end
		end

		def calculate_redcard
			redcard.joins(:team).where(:team => {:red => true}).each do |team|
				team.update_attribute(:score, 5)
			end
		end

		def reset_redcard
			redcard.each do |team|
				team.update_attribute(:score, nil)
			end
		end
	end



end
