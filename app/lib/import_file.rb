require 'roo'
class ImportFile

	attr_accessor :file

	def initialize
		@file = Roo::Spreadsheet.open('app/excel/totaal_pool.xlsx')
	end


	def test_games

		file.each_with_pagename do |name, sheet|
			next if name =~/Totaal/
			
			[(9..14), (17..22) ,(25..30), (33..38), (41..46), (49..54)].each do |arr|
				a = []
				arr.each do |x|
	  				a.push sheet.cell(x,10)
	  				a.push sheet.cell(x,12)
  				end
  				
	  			if a.compact.size !=12
	  				byebug
	  			end


	  		end

		end


	end


	def test_teams

		file.each_with_pagename do |name, sheet|
			next if name =~/Totaal/
			
			[[(9..24),16], [(29..36),8] ,[(41..44),4], [(49..50),2], [(55..55),1]].each do |arr|
				a = []
				arr[0].to_a.each do |x|
	  					a.push sheet.cell(x,16)
  				end
  				p a.size
	  			if a.size !=arr[1]
	  				byebug
	  			end
	  			if a.compact.size !=arr[1]
	  				byebug
	  			end


	  		end

		end

	end

	def test_team_names
		names = []
		file.each_with_pagename do |name, sheet|
			next if name =~/Totaal/
			
			

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
			next if name =~/Totaal/

				country = sheet.cell(63,11) || ""
				if country
					country = country.strip.downcase
				end

	  			names.push country

	  			unless return_official_team_name(country)
	  				byebug
	  			end

		end	

		names.map{|x| x.strip.downcase}.uniq.sort		
	end


	def test_topscorer
		names = []
		file.each_with_pagename do |name, sheet|
			next if name =~/Totaal/

				country = sheet.cell(59,11) || ""
				if country
					country = country.strip.downcase
				end

	  			names.push country

	  			unless return_official_team_name(country)
	  				byebug
	  			end

		end	

		names.map{|x| x.strip.downcase}.uniq.sort		
	end

	def test_topplayer
		names = []
		file.each_with_pagename do |name, sheet|
			next if name =~/Totaal/

				country = sheet.cell(61,11) || ""
				if country
					country = country.strip.downcase
				end

	  			names.push country

	  			unless return_official_team_name(country)
	  				byebug
	  			end

		end	

		names.map{|x| x.strip.downcase}.uniq.sort		
	end
# first find all name-entrys, stripped, downcased and uniq as returned by method test_team_names
# list the 24 official names from the database
# try to match each entry by the first 1-2-3-4 letters to only one of an official name
# return the official name
	def return_official_team_name(entry)
		case entry 



			when /^au|^oo/
				"austria"
			when /^be/
				"belgium"
			when /^ch|^cz|^tj|^ts/
				"chech republic"
			when /^cr|^kr/
				"croatia"
			when /^de/
				"denmark"
			when /^en/
				"england"
			when /^fi/
				"finland"
			when /^fr/
				"france"
			when /^du|^ge/
				"germany"
			when /^ho/
				"hongarije"
			when /^it/
				"italy"
			when /^ma/
				"macedonie"
			when /^ne/
				"netherlands"
			when /^pol/
				"poland"
			when /^por|pot/
				"portugal"
			when /^ru/
				"russia"
			when /^sc/
				"schotland"
			when /^sl/
				"slowakije"
			when /^sp/
				"spain"
			when /^swe|^zwe/
				"sweden"
			when /^swi|^zwi/
				"switzerland"
			when /^tu/
				"turkey"
			when /^oe|^uk/
				"ukraine"
			when /^wa/
				"wales"
			end
		end

end


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
