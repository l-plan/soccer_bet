class Fifa::Ranking < ApplicationRecord
	belongs_to :team, class_name: "Team"
end
