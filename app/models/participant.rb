class Participant < ApplicationRecord
	has_many :games, class_name: "Bet::Game"
	has_many :teams, class_name: "Bet::Team"
	has_one :topplayer, class_name: "Bet::Topscorer"
	has_one :topscorer, class_name: "Bet::Topplayer"


	has_one :redcard, -> { redcard }, class_name: 'Bet::Team'
	has_one :winner, -> { winner }, class_name: 'Bet::Team'
	has_many :finalists, -> { finale }, class_name: 'Bet::Team'
	has_many :semifinalists, -> { semifinal }, class_name: 'Bet::Team'
	has_many :quarterfinalists, -> { quarterfinal }, class_name: 'Bet::Team'
	has_many :eightfinalists, -> { eightfinal }, class_name: 'Bet::Team'
end
