class CalculationsController < ApplicationController
	def index
		@stages = ordered_stages
	end

	def calculate_stage
		calculation_params[:klass].constantize.send("calculate_#{calculation_params[:stage]}")
		redirect_to action: :index
	end

	def reset_stage
		calculation_params[:klass].constantize.send("reset_#{calculation_params[:stage]}")
		redirect_to action: :index
	end

	def calculate_fifa_poule_rankings
		Team.calculate_fifa_poule_rankings
		redirect_to action: :index
	end

	def reset_fifa_poule_rankings
		Team.reset_fifa_poule_rankings
		redirect_to action: :index
	end

	def calculate_participants_poule_rankings
		Bet::Team.calculate_participants_poule_rankings
		redirect_to action: :index
	end

	def reset_participants_poule_rankings
		Bet::Team.reset_participants_poule_rankings
		redirect_to action: :index
	end


	private

	def calculation_params
		params.require(:calculation).permit(:stage, :klass)
	end

	def ordered_stages
		games = ["pool"].map{|x| [x, Bet::Game]}

		teams = ["poule_score","poule_bonus","sixteenfinal","eightfinal","quarterfinal", "semifinal", "finale","winner","redcard"].map{|x| [x, Bet::Team]}
		players = ["topscorer","topplayer"].map{|x| [x, Bet::Player]}
		games+teams+players

	end
end
