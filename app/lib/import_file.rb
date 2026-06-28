require 'roo'

class ImportFile
	include NamesHelper

	attr_accessor :file, :participant, :team_entries


	def initialize
		@file = Roo::Spreadsheet.open('app/excel/wk26_totaal.xlsx')
		@warnings = Hash.new
	end


	def import_group_bets


		 file.each_with_pagename do |name, sheet|
		 	next unless name.downcase.match(/groep/)

		 	@participant = Participant.find_or_create_by(name:  name[11,40] )

		 	(9..80).each do |x|
				# nr = 
				line = sheet.row(x)
				nr = line[0]
				home = line[4]
				away = line[5]

				participant.faxes.create(stage: 'pool', error: "no entry", message: "no home score game #{nr}") if home.blank?
				participant.faxes.create(stage: 'pool', error: "no entry", message: "no away score game #{nr}") if away.blank?

				game_id = Game.find_by(nr: nr).id
				participant.games.create(game_id: game_id, home: home, away: away)

			end

		 end

	end


	def import_knock_out_bets
		file.each_with_pagename do |name, sheet|
			next unless name.downcase =~/knock-out/

			part = name.downcase.downcase.gsub(/knock-out /, '').strip

			@participant = Participant.find_by(name: part)

			import_teams(sheet, 2 , 32, "sixteenfinal")
			import_teams(sheet, 5 , 16, "eightfinal")
			import_teams(sheet, 8 , 8, "quarterfinal")
			import_teams(sheet, 11 , 4, "semifinal")
			import_teams(sheet, 14 , 2, "finale")
			import_teams(sheet, 17 , 1, "winner")

			import_redcard(sheet,"redcard")

			import_topscorer(sheet, "topscorer")
			import_topplayer(sheet, "topplayer")
			import_goals(sheet, "goals")




		end

	end

	def import_topscorer(sheet, stage)
		entry = sheet.cell(22,11)
		name = return_official_player_name(entry.strip.downcase)

		participant.faxes.create(stage: stage, error: "no entry" ) if entry.blank?

		player = Player.find_or_create_by(name:  name ).id

		participant.players.create(stage: stage, player_id: player, stage: stage)


	end

	def import_topplayer(sheet, stage)
		entry = sheet.cell(24,11)
		name = return_official_player_name(entry.strip.downcase)

		participant.faxes.create(stage: stage, error: "no entry" ) if entry.blank?

		player = Player.find_or_create_by(name:  name ).id

		participant.players.create(stage: stage, player_id: player, stage: stage)



	end

	def import_redcard(sheet, stage)
		entry = sheet.cell(23,11)

		return participant.faxes.create(stage: stage, error: "no entry" ) if entry.blank?

		name = return_official_team_name(entry.strip.downcase)

		team = Team.find_by(name: name )&.id

		return participant.faxes.create(stage: stage, error: "not found", message: entry ) if team.nil?

		participant.teams.create(stage: stage, team_id: team, stage: stage)

		
		
	end

	def import_goals(sheet, stage)
		entry = sheet.cell(26,11)
		return participant.faxes.create(stage: stage, error: "no entry" ) if entry.blank?

		# participant.goal.create(amount: entry.to_i)
		participant.build_goal(amount: entry.to_i).save
		
	end






	# def import_poule_score(sheet,range, stage,column)
	# 	%w(a b c d e f g h i j k l).each do |poule_letter|
	# 		@participant.teams.build(stage: 88,poule: poule_letter )
	# 	end
		
	# 	poule = "a"

	# 	poule_rank = 1
	# 	range.each do |x|

	# 			letter = sheet.cell(x,11)
		
	# 			if letter and letter.size > 3
	# 				poule=letter.last.downcase
	# 			end


	# 			name = sheet.cell(x,column)
	# 			next if name.blank?



		




	# 			name = name.strip.downcase


				

	# 			name = return_official_team_name(name)


	# 			# unless name
	# 			# 	binding.b
	# 			# end
	# 			team_id = Team.find_by(name: name )&.id	
				
	# 			@participant.teams.build(stage: stage, team_id: team_id,poule: poule, poule_rank: poule_rank )

	# 			poule_rank += 1
	# 			poule_rank = 1 if poule_rank == 5
	# 	end
	# end



	def import_games


		sheet = file.sheet(1)

		(9..80).each do |x|
				
				line = sheet.row(x)


				nr = line[0]
				date = Date.parse( line[1] )

				home_id = Team.find_by(name: line[3] )&.id
				away_id = Team.find_by(name: line[6])&.id

				game = Game.create(nr: nr, home_id: home_id, away_id: away_id, date: date, stage: 'pool')
		
	
		end

		# @participant.save
	end

	def import_teams(sheet, column, amount, stage)


		entries = sheet.column(column).compact[0,amount]
		arr = []

		entries.each do |entry|
			name = return_official_team_name(entry.strip.downcase)
			next if name =~ /not-found/
			team = Team.find_by(name: name )
			arr.push team.id
			
		end

		arr.compact.uniq.each do |team|
			participant.teams.build(stage: stage, team_id: team, stage: stage)
		end

		# if participant.id == 35
		# 	binding.b
		# end

		participant.save
		check_for_team_warnings(stage)
		


	end	

	def find_team_entries
		team_entries = []
		
		file.each_with_pagename do |name, sheet|
			arr = []
			next unless name.downcase =~/knock-out/
			part = name.downcase.downcase.gsub(/knock-out /, '').strip

			@participant = Participant.find_by(name: part)
	
			arr << [sheet.column(2).compact[0,32],sheet.column(5).compact[0,16],sheet.column(8).compact[0,8],sheet.column(11).compact[0,4],
				sheet.column(14).compact[0,2],sheet.column(17).compact[0,1], sheet.cell(23,11)]
			
			arr.flatten.compact.each do |entry|
				team_entries << entry.downcase.strip
			end

		end
		
		[team_entries.size,team_entries.uniq.sort]

	end


	def find_player_entries
		entries = []
		
		file.each_with_pagename do |name, sheet|
			arr = []
			next unless name.downcase =~/knock-out/
			part = name.downcase.downcase.gsub(/knock-out /, '').strip

			@participant = Participant.find_by(name: part)
	
			arr << [sheet.cell(22,11), sheet.cell(24,11)]
			
			arr.flatten.compact.each do |entry|
				entries << entry.downcase.strip
			end

		end
		
		[entries.size,entries.uniq.sort]

	end

	def check_for_team_warnings(stage)
			amount = 0
			case stage
				when "sixteenfinal"
					amount = 32
				when "eightfinal"
					amount = 16
				when "quarterfinal"
					amount = 8
				when "semifinal"
					amount = 4
				when "finale"
					amount = 2
				when "winner"
					amount = 1
			end

		size = @participant.teams.select{|x| x.stage==stage}.size
		unless size==amount
			participant.faxes.create(stage: stage)
		end
	end

	def check_for_player_warnings(stage)
		size = @participant.players.select{|x| x.stage==stage}.size
		unless size==1
			participant.faxes.create(stage: stage)
		end

	end

	def check_sheet(part)
		participant = Participant.find(part)
		arr = []
		(1..72).each do |nr|
			game = Game.find_by(nr: nr)
			arr << participant.games.find{|x| x.game_id == game.id}.score
		end
		arr
	end



end







