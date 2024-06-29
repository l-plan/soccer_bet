require 'roo'

class ImportFile
	include NamesHelper

	attr_accessor :file, :participant, :warnings


	def initialize
		@file = Roo::Spreadsheet.open('app/excel/totaal_pool_24.xlsx')
		@warnings = Hash.new
	end


	def import_participants
		file.each_with_pagename do |name, sheet|
			next if name =~/Deelnemers/

			set_participant(sheet)
			import_games(sheet)



			import_teams(sheet, (59..74), "eightfinal",2)

			import_teams(sheet, (59..66), "quarterfinal", 5)

			import_teams(sheet, (59..62), "semifinal", 8)

			import_teams(sheet, (59..60), "finale",11)

			import_teams(sheet, (59..59), "winner",14)

			import_teams(sheet, (72..72), "redcard",8)

			import_players(sheet)

			import_poule_score(sheet, (12..50), "poule_score",12)
	
			@participant.save


		end

	end

	def import_poule_score(sheet,range, stage,column)
		%w(a b c d e f).each do |poule_letter|
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


				unless name
					binding.b
				end
				team_id = Team.find_by(name: name )&.id	
				
				@participant.teams.build(stage: stage, team_id: team_id,poule: poule, poule_rank: poule_rank )

				poule_rank += 1
				poule_rank = 1 if poule_rank == 5
		end
	end

	# def set_participant(sheet)
	# 	part = 	sheet.cell(3,2)
	# 	email = sheet.cell(4,2)
	# 	@participant = Participant.find_by(name: part, email: email) || Participant.new(name: part, email: email)
	# end



	def import_games(sheet)
		# set_participant(sheet)
		[(12..17), (19..24) ,(26..31), (33..38), (40..45), (47..52)].each do |arr|
			arr.to_a.each do |x|

				home_id = Team.find_by(name: return_official_team_name(sheet.cell(x,3).strip.downcase ) )&.id
				away_id = Team.find_by(name: return_official_team_name(sheet.cell(x,5).strip.downcase  ) )&.id

				game = Game.find_by(home_id: home_id, away_id: away_id, stage: "pool")
				unless game
					binding.b
				end
				home 	= sheet.cell(x,7)
				away 	= sheet.cell(x,9)
	
				@participant.games.build(game_id: game.id, home: home, away: away)

			
			end

			
		end

		# @participant.save
	end

	def import_teams(sheet, range, stage, column)
		
			range.to_a.each do |x|
				name = sheet.cell(x,column)
				next if name.blank?
				name = name.strip.downcase

				

				name = return_official_team_name(name)

				team_id = Team.find_by(name: name )&.id

				# unless team_id
				# 	binding.b
				# end	

				@participant.teams.build(stage: stage, team_id: team_id)


	  		end

			check_for_team_warnings(stage)


	end	

	def check_for_team_warnings(stage)
			amount = 1
			case stage
				when "eightfinal"
					amount = 16
				when "quarterfinal"
					amount = 8
				when "semifinal"
					amount = 4
				when "finale"
					amount = 2
			end

		size = @participant.teams.select{|x| x.stage==stage}.size
		unless size==amount
			warnings[@participant.name] = {} unless warnings[@participant.name]

			warnings[@participant.name][stage] = "#{@participant.name} only has #{size} entries out of #{amount} for #{stage}"
		end
	end

	def check_for_player_warnings(stage)
		size = @participant.players.select{|x| x.stage==stage}.size
		unless size==1
			warnings[@participant.name] = {} unless warnings[@participant.name]
			warnings[@participant.name][stage] = "#{@participant.name} only has no entry for #{stage}"
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







