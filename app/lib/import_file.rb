require 'roo'
class ImportFile

	attr_accessor :file, :participant


	def initialize
		@file = Roo::Spreadsheet.open('app/excel/totaal_pool_24.xlsx')
	end


	def import_participants
		file.each_with_pagename do |name, sheet|
			next if name =~/Deelnemers/
			part = 	sheet.cell(3,2)
			email = sheet.cell(4,2)
			@participant = Participant.new(name: part, email: email)

			import_games(sheet)

			# import_poule_eindstand

			# import_teams(sheet, (59..74), "eightfinal",2)

			# import_teams(sheet, (59..66), "quarterfinal", 5)

			# import_teams(sheet, (59..62), "semifinal", 8)

			# import_teams(sheet, (59..60), "finale",11)

			# import_teams(sheet, (59..59), "winner",14)

			# import_teams(sheet, (72..72), "redcard",8)

			# import_players(sheet)


	
			@participant.save


		end

	end



	def import_games(sheet)
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
	end

	def import_teams(sheet, range, stage, column)
		# [(9..24),16], [(29..36),8] ,[(41..44),4], [(49..50),2], [(55..55),1]]
			
			range.to_a.each do |x|
				name = sheet.cell(x,column).strip.downcase

				name = return_official_team_name(name)

				team_id = Team.find_by(name: name )&.id

				unless team_id
					binding.b
				end	

				@participant.teams.build(stage: stage, team_id: team_id)


	  		end



	end	

	def import_players(sheet)
		# [(9..24),16], [(29..36),8] ,[(41..44),4], [(49..50),2], [(55..55),1]]
			

				toppscorer = sheet.cell(59,11).strip.downcase

				toppscorer = return_official_player_name(toppscorer)

				player_id = Player.find_by(name: toppscorer )&.id

				unless player_id
					binding.b
				end	

				@participant.players.build(player_id: player_id, stage: "topscorer")

				topplayer = sheet.cell(61,11).strip.downcase

				topplayer = return_official_player_name(topplayer)

				player_id = Player.find_by(name: topplayer )&.id

				unless player_id
					binding.b
				end	


				@participant.players.build(player_id: player_id, stage: "topplayer")
	



	end	

	# def import_8_finalists(sheet)
	# 	# [(9..24),16], [(29..36),8] ,[(41..44),4], [(49..50),2], [(55..55),1]]
			
	# 		(9..24).to_a.each do |x|
	# 			name = sheet.cell(x,16).strip.downcase

	# 			name = return_official_team_name(name)

	# 			team_id = Team.find_by(name: name )&.id

	# 			unless team_id
	# 				binding.b
	# 			end	

	# 			@participant.teams.build(stage: "eightfinal", team_id: team_id)


	#   		end



	# end





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


	def test_topscorer
		names = []
		file.each_with_pagename do |name, sheet|
			next if name =~/Deelnemers/

				player = sheet.cell(59,11) || ""
				if player
					player = player.strip.downcase
				end

	  			names.push player

	  			
	  			unless return_official_player_name(player)
	  				binding.b
	  			end

		end	


		names.map{|x| x.strip.downcase}.uniq.sort		
	end

	def test_topplayer
		names = []
		file.each_with_pagename do |name, sheet|
			next if name =~/Deelnemers/

				player = sheet.cell(61,11) || ""
				if player
					player = player.strip.downcase
				end

	  			names.push player

	  			unless return_official_player_name(player)
	  				binding.b
	  			end

		end	

		names.map{|x| x.strip.downcase}.uniq.sort		
	end



# first find all name-entrys, stripped, downcased and uniq as returned by method test_team_names
# list the 24 official names from the database
# try to match each entry by the first 1-2-3-4 letters to only one of an official name
# return the official name
	def return_official_team_name(entry)
		case entry.downcase 



			when /^alb/
				"Albanie"
			when /^bel/
				"Belgie"
			when /^den/
				"Denemarken"
			when /^dui/
				"Duitsland"
			when /^en/
				"Engeland"
			when /^fr/
				"Frankrijk"
			when /^geo/
				"Georgie"
			when /^hon/
				"Hongarije"
			when /^ita/
				"Italie"
			when /^kro/
				"Kroatie"
			when /^ned/
				"Nederland"
			when /^oek/
				"Oekraine"
			when /^oos/
				"Oostenrijk"
			when /^pol/
				"Polen"
			when /^por/
				"Portugal"
			when /^roe/
				"Roemenie"
			when /^sch/
				"Schotland"
			when /^ser/
				"Servie"
			when /^slov/
				"Slovenie"
			when /^slow/
				"Slowakije"
			when /^spa/
				"Spanje"
			when /^tje/
				"Tjechie"
			when /^tur/
				"Turkije"
			when /^zwi/
				"Zwitserland"

		end
	end

end


# first find all player-entrys, stripped, downcased and uniq as returned by method test_topscorer or test_topplayer
# list the 24 official player-names from the database
# try to match each entry by the first 1-2-3-4 letters to only one of an official name
# return the official name

	def return_official_player_name(entry)
		case entry
			when /benz/
				"benzema"
			when /brui|bruy/
				"bruyne"
			when /cour/
				"courtois"
			when /jong/
				"de jong"
			when /ligt/
				"de ligt"
			when /depa/
				"depay"
			when /gnab/
				"gnabri"
			when /grav/
				"gravenberg"
			when /hav/
				"havertz"
			when /immo/
				"immobile"
			when /ins/
				"insigne"
			when /kane/
				"kane"
			when /kant/
				"kante"
			when /lewa/
				"lewandowski"
			when /luk/
				"lukaku"
			when /mba|mapp|mpab/
				"mbappe"
			when /mor/
				"morata"
			when /moun/
				"mount"
			when /rash/
				"rashford"
			when /rona/
				"ronaldo"
			when /san/
				"sane"

		end
	end
#player-entrys
	# "alvaro morata"
	# "benzema"
	# "c. immobile"
	# "de bruijne"
	# "depay"
	# "harry kane"
	# "havertz"
	# "k. mbappé"
	# "kane"
	# "karim benzema"
	# "kylian mbappe"
	# "kylian mbappé"
	# "leroy sane"
	# "lewandowski"
	# "lukaku"
	# "mappee"
	# "mbappe"
	# "mbappé"
	# "mpabbe"
	# "rashford"
	# "romelu lukaku"
	# "serge gnabry"

	# "courtois"
	# "de bruyne"
	# "de ligt"
	# "frenkie de jong"
	# "gravenberg"
	# "harry kane"
	# "k. mbappé"
	# "kante (frankrijk)"
	# "kylian mbappe"
	# "kylian mbappé"
	# "leroy sané"
	# "lewandovski"
	# "lorenzo insigne"
	# "lukaku"
	# "mappee"
	# "mason mount"
	# "mbape"
	# "mbappe"
	# "mbappé"
	# "n'golo kanté"
	# "ngolo kante"
	# "ronaldo"

#entries:
			# "austria"
			# "begie"
			# "belgie"
			# "belgium"
			# "belgië"
			# "chech rep"
			# "chech republic"
			# "chechrepublic"
			# "croatia"
			# "croatie"
			# "croatië"
			# "czech republic"
			# "denemarken"
			# "denmark"
			# "duitsland"
			# "duitslang"
			# "engeland"
			# "engelend"
			# "england"
			# "finland"
			# "france"
			# "frankrijk"
			# "germany"
			# "hongarije"
			# "italie"
			# "italië"
			# "italy"
			# "kroatie"
			# "kroatië"
			# "macedonie"
			# "nederland"
			# "netherlands"
			# "oekraiene"
			# "oekraine"
			# "oekraïne"
			# "oostenrijk"
			# "poland"
			# "polen"
			# "portugal"
			# "potugal"
			# "rusland"
			# "russia"
			# "schotland"
			# "slowakije"
			# "spain"
			# "spanje"
			# "sweden"
			# "switserland"
			# "switzerland"
			# "tjechie"
			# "tjechië"
			# "tsjechie"
			# "turkey"
			# "turkije"
			# "turkijke"
			# "ukraine"
			# "wales"
			# "zweden"
			# "zwisterland"
			# "zwitersland"
			# "zwitserland"



