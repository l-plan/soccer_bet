class Fifa::FairPlayRanking < ApplicationRecord
	belongs_to :team, class_name: "Team"
end
