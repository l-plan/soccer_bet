class Bet::Team < ApplicationRecord
	enum :stage, {winner: 6, finale: 5, semifinal: 4, quarterfinal: 3, eightfinal: 2, pool: 0, redcard: 99, poule_score: 77, poule_bonus: 88, sixteenfinal: 1, goals: 98}


	belongs_to :participant
	belongs_to :team, class_name: "::Team", optional: true

	scope :bonus, -> (poule){where(stage: :poule_bonus, poule: poule)}
	scope :knockout, -> {where(stage: [:finale, :semifinal, :quarterfinal, :eightfinal, :sixteenfinal])}
	scope :pouleranking, -> {where(stage: [:poule_score, :poule_bonus])}

	scope :updated, ->(stage){where(stage: stage).order(:updated_at)}



	class << self


		def calculate_participants_poule_rankings
			poule_score.delete_all
			%w(a b c d e f g h i j k l).each do |poule|
				Participant.all.each do |part|
					Ranking.new(poule, part.id ).bet_poule_ranking. each do |rank|

						part.teams.build(stage: 'poule_score', team_id: rank[1], poule: poule, poule_rank: rank[0])
					end
					part.save
				end
			end
		end


		def self.calculate_participants_poule_rankings
			%w(a b c d e f g h i j k l).each do |poule|
				Ranking.new(poule).fifa_poule_ranking.each do |rank|
					self.find(rank[1]).update_attribute(:poule_rank, rank[0])
				end
			end
		end

		

		def reset_participants_poule_rankings
			poule_score.delete_all
		end


		def calculate_poule_score
			poule_score.each{|x| x.update_attribute(:score, 1) if x.team.poule_rank == x.poule_rank}
		end

		def reset_poule_score
			poule_score.each{|x| x.update_attribute(:score, nil)}
		end

		def calculate_poule_bonus
			poule_score.group_by{|x| [x.participant_id, x.poule]}.each do |k,v|
				sum = v.collect(&:score).compact.sum
				next unless sum==4
				Bet::Team.find_or_create_by(participant_id: k[0], poule: k[1], stage: 'poule_bonus').update_attribute(:score, 2)
			end
		end

		def reset_poule_bonus
			poule_bonus.each{|x| x.update_attribute(:score, nil)}
		end


		def calculate_sixteenfinal
			sixteenfinal.joins(:team).where(:team => {:fin32 => true}).each do |team|
				team.update_attribute(:score, 1)
			end
		end

		def reset_sixteenfinal
			sixteenfinal.each do |team|
				team.update_attribute(:score, nil)
			end
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
