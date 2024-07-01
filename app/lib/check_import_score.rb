require 'roo'

class CheckImportScore
	include NamesHelper

	attr_accessor :file, :participant, :warnings, :xls, :games, :game_errors, :poule_errors, :bonus, :poule, :bonus_errors


	def initialize
		@file = Roo::Spreadsheet.open('app/excel/totaal_pool_24.xlsx')
		@xls = Spreadsheet::Workbook.new
		@warnings = Hash.new
		@games = set_games
		@poule = set_poule
		@bonus = set_bonus

		check_games
		check_poule
		check_bonus



	end

	def check_games

		
		@game_errors = []
		file.each_with_pagename do |name, sheet|
			next if name =~/Deelnemers/
			
			participant = Participant.find_by(name: sheet.cell(3,2) )
			poule_games = participant.games

			games.each do |game|
				row = game[0]
				id = game[1]
				teams = game[2]
				result = game[3]
				bet = poule_games.find{ |x| x.game_id==id }

				next if sheet.cell(row, 10).to_i == bet.score
				arr = [participant.name, row, teams, result, "#{bet.home}-#{bet.away}",   sheet.cell(row, 10), bet.score]
				@game_errors << arr
			end



		end
		nil
		# xls.write('/users/rolf/check.xls')
		# @errors

	end


	def game_header
		['name', 'regel', 'wedstrijd', 'uitslag', 'voorspelling',  'freek', 'rolf']
	end


	def check_poule
		@poule_errors = []
		file.each_with_pagename do |name, sheet|
			next if name =~/Deelnemers/
			participant = Participant.find_by(name: sheet.cell(3,2) )
			bets = participant.poule_scores
			bonuses = participant.poule_bonuses

			rows = 12..50

			rows.each do |row|
				country = sheet.cell(row,12)
				next if country.blank?
				country = poule.find{|x| x[0] == return_official_team_name(country)}
				bet = bets.find{|x| x.team_id==country[1]}

				next if bet.score == sheet.cell(row, 13).to_i

				arr = [participant.name, row, country[0], country[2], country[3],sheet.cell(row, 11), sheet.cell(row, 13) , bet.score]
				@poule_errors << arr

			end

		end

	end

	def check_bonus
		@bonus_errors = []
		file.each_with_pagename do |name, sheet|
			next if name =~/Deelnemers/
			participant = Participant.find_by(name: sheet.cell(3,2) )

			bonuses = participant.poule_bonuses.map{|x| [x.poule, x.score||0]}

			freek = sheet.column(13)[11,42].in_groups_of(7)

			result = %w(a b c d e f).each_with_index.map{|x,i|[x, freek[i][4,3].compact.sum] }

			result.each do |res|
				# binding.b
				poule = res[0]
				freek = res[1]
				score = bonuses.find{|x| x[0]==poule}[1]
				next if freek==score

				arr = [participant.name, poule, freek, score]
				@bonus_errors << arr
			end

		end
	end


	def print_errors
		check = xls.create_worksheet :name => 'check-games'
		row = 0
		check.row(0).concat game_header
		row+=1
		game_errors.each do |err|
			check.row(row).concat err
			row+=1
		end


		check = xls.create_worksheet :name => 'check-poule'
		row = 0
		check.row(0).concat poule_header
		row+=1
		poule_errors.each do |err|
			check.row(row).concat err
			row+=1
		end


		check = xls.create_worksheet :name => 'check-bonus'
		row = 0
		check.row(0).concat bonus_header
		row+=1
		bonus_errors.each do |err|
			check.row(row).concat err
			row+=1
		end
		xls.write('/users/rolf/check.xls')

	end

	def poule_header
		['name', 'regel', 'land', 'poule', 'plek','plek freek','pnt freek', 'pnt rolf']
	end


	def bonus_header
		['name', 'poule', 'pnt freek', 'pnt rolf']
	end

	def set_games
		sheet = file.sheet('Han')
		arr = []
		reg = 12
		(12..52).each_with_index do |x, i|
				next if sheet.cell(x,1).blank?

				home_id = Team.find_by(name: return_official_team_name(sheet.cell(x,3).strip.downcase ) )&.id
				away_id = Team.find_by(name: return_official_team_name(sheet.cell(x,5).strip.downcase  ) )&.id

				game = Game.find_by(home_id: home_id, away_id: away_id, stage: "pool")

				arr<<[12+i, game.id,"#{game.home.name}-#{game.away.name}", "#{game.score_home}-#{game.score_away}" ]
		
		end
		arr
	end

	def set_poule
		Team.all.map{|x| [x.name, x.id, x.poule,x.poule_rank]}
	end

	def set_bonus
		Bet::Team
	end

end





