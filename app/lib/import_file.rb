require 'roo'

class ImportFile
	include NamesHelper

	attr_accessor :file, :participant, :team_entries


	def initialize
		# @file = Roo::Spreadsheet.open('app/excel/totaal_pool_24.xlsx')
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

				game_id = Game.find_by(nr: nr).id
				@participant.games.create(game_id: game_id, home: home, away: away)

			end

		 end

	end


	def import_knock_out_bets
		file.each_with_pagename do |name, sheet|
			next unless name.downcase =~/knock-out/

			part = name.downcase.downcase.gsub(/knock-out /, '').strip

			@participant = Participant.find_by(name: part)

			import_teams(sheet, 2 , 32, "sixteenfinal")
		end

	end


	def import_participants
		arr = []
		file.each_with_pagename do |name, sheet|
			next unless name.downcase =~/knock-out/

			part = name.downcase.downcase.gsub(/knock-out /, '').strip

			@participant = Participant.find_by(name: part)


			# import_games(sheet)

			import_teams(sheet, (10..41), "sixteenfinal",2)

			# import_teams(sheet, (10..41), "eightfinal",2)

			# import_teams(sheet, (59..66), "quarterfinal", 5)

			# import_teams(sheet, (59..62), "semifinal", 8)

			# import_teams(sheet, (59..60), "finale",11)

			# import_teams(sheet, (59..59), "winner",14)

			# import_teams(sheet, (72..72), "redcard",8)

			# import_players(sheet)

			# import_poule_score(sheet, (12..50), "poule_score",12)
	
			# @participant.save


		end
		arr
	end

	def import_poule_score(sheet,range, stage,column)
		%w(a b c d e f g h i j k l).each do |poule_letter|
			@participant.teams.build(stage: 88,poule: poule_letter )
		end
		
		poule = "a"

		poule_rank = 1
		range.each do |x|

				letter = sheet.cell(x,11)
		
				if letter and letter.size > 3
					poule=letter.last.downcase
				end


				name = sheet.cell(x,column)
				next if name.blank?



		




				name = name.strip.downcase


				

				name = return_official_team_name(name)


				# unless name
				# 	binding.b
				# end
				team_id = Team.find_by(name: name )&.id	
				
				@participant.teams.build(stage: stage, team_id: team_id,poule: poule, poule_rank: poule_rank )

				poule_rank += 1
				poule_rank = 1 if poule_rank == 5
		end
	end



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
		# import_teams(sheet, (10..41), "sixteenfinal",2)

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
		
			# range.to_a.each do |x|
			# 	name = sheet.cell(x,column)
			# 	next if name.blank?
			# 	name = name.strip.downcase

				

			# 	name = return_official_team_name(name)

			# 	team = Team.find_by(name: name )


			# 	participant.teams.build(stage: stage, team_id: team&.id, poule: team&.poule)


	  		# end

			# check_for_team_warnings(stage)
			warnings

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

	def check_for_group_warnings


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


			end

		 end

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

	def import_players(sheet)

				# binding.b
				toppscorer = sheet.cell(71,8)

				unless toppscorer.blank?
					toppscorer = sheet.cell(71,8).strip.downcase

					toppscorer = return_official_player_name(toppscorer)

					player_id = Player.find_by(name: toppscorer )&.id

					unless player_id
						binding.b
					end	

					@participant.players.build(player_id: player_id, stage: "topscorer")

				end

				topplayer = sheet.cell(73,8)

				unless topplayer.blank?

					topplayer = sheet.cell(73,8).strip.downcase

					topplayer = return_official_player_name(topplayer)

					player_id = Player.find_by(name: topplayer )&.id

					unless player_id
						binding.b
					end	


					@participant.players.build(player_id: player_id, stage: "topplayer")
				end
	
				@participant.save


	end	







	def test_participant_names
		names = []
		file.each_with_pagename do |name, sheet|
			next if name =~/Deelnemers/

				part = sheet.cell(3,2) || ""
				if part.blank?
					# binding.b
				else
					part = part.strip.downcase
					names.push part

				end

		end	
		binding.b
		names.map{|x| x.strip.downcase}.uniq.sort

	end

	def test_participant_email
		names = []
		file.each_with_pagename do |name, sheet|
			next if name =~/Deelnemers/

				part = sheet.cell(4,2) || ""
				if part.blank?
					# binding.b
				else
					part = part.strip.downcase
					names.push part

				end

		end	

		names.map{|x| x.strip.downcase}.uniq.sort	
	end
	def test_games

		file.each_with_pagename do |name, sheet|
			next if name =~/Deelnemers/
			
			[(12..17), (19..24) ,(26..31), (33..38), (40..45), (47..52)].each do |arr|
				a = []
				arr.each do |x|
	  				a.push sheet.cell(x,3)
	  				a.push sheet.cell(x,5)
  				end

	  			if a.compact.size !=12
	  				binding.b
	  			end


	  		end

		end


	end


	def test_teams

		file.each_with_pagename do |name, sheet|
			next if name =~/Deelnemers/
			
			[[(12..2),16], [(29..36),8] ,[(41..44),4], [(49..50),2], [(55..55),1]].each do |arr|
				a = []
				arr[0].to_a.each do |x|
	  				a.push sheet.cell(x,16)
  				end
  				p a.size
	  			if a.size !=arr[1]
	  				binding.b
	  			end
	  			if a.compact.size !=arr[1]
	  				binding.b
	  			end


	  		end

		end

	end

	def test_team_names
		names = []
		file.each_with_pagename do |name, sheet|
			next if name =~/Deelnemers/
			
			

			[[(9..24),16], [(29..36),8] ,[(41..44),4], [(49..50),2], [(55..55),1]].each do |arr|

				arr[0].to_a.each do |x|
	  					names.push sheet.cell(x,16)
  				end



	  		end

	  		

		end	

		names.map{|x| x.strip.downcase}.uniq.sort
	end

	def test_red_card
		names = []
		file.each_with_pagename do |name, sheet|
			next if name =~/Deelnemers/

				country = sheet.cell(63,11) || ""
				if country
					country = country.strip.downcase
				end

	  			names.push country

	  			unless return_official_team_name(country)
	  				binding.b
	  			end

		end	

		names.map{|x| x.strip.downcase}.uniq.sort		
	end


	def test_players
		names = []
		file.each_with_pagename do |name, sheet|
			next if name =~/Deelnemers/

			player = sheet.cell(71,8)
			unless player.blank?
				player = player.strip.downcase
			end

  			names.push player


			player = sheet.cell(73,8)
			unless player.blank?
				player = player.strip.downcase
			end

  			names.push player	  			
  			# unless return_official_player_name(player)
  			# 	binding.b
  			# end

		end	


		names.map{|x| x.strip.downcase}.uniq.sort		
	end







end







