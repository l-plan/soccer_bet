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



	private

	def calculation_params
		params.require(:calculation).permit(:stage, :klass)
	end

	def ordered_stages
		games = ["pool"].map{|x| [x, Bet::Game]}
		teams = ["poule_score","poule_bonus","eightfinal","quarterfinal", "semifinal", "finale","winner","redcard"].map{|x| [x, Bet::Team]}
		players = ["topscorer","topplayer"].map{|x| [x, Bet::Player]}
		games+teams+players

	end
end
