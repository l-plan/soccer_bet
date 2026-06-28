module Pdf::ParticipantHelper
	include ::ParticipantsHelper


	def print_participant_page(participant)
		print_participant_header(participant)
		h 20
		print_sixteenfinalists(participant)
		# print_eigthfinalists(participant)
		h -460
		print_games(participant)

		# h -700
		h -550
		# print_sixteenfinalists(participant)

		print_eigthfinalists(participant)

		h 10
		print_quarterfinalists(participant)
		h 10
		print_semifinalists(participant)
		h 10
		print_finalists(participant)

		print_winner(participant)

		print_topplayer(participant)

		print_topscorer(participant)

		print_redcard(participant)

		print_goals(participant)
		# h 50
		pdf.start_new_page
		print_poule_ranking(participant)

		# h 50


	end

	def print_goals(participant)
		arr = goals_array(participant)

		pdf.table( arr, :column_widths => [80, 80, 25], :cell_style=>cellstyle , position: 310) do
			column(2).style :align => :right
			column(0).style :font_style=> :bold	
		end
	end

	def print_participant_header(participant)

		arr = participant_header_array(participant)

		pdf.table( arr, :column_widths => [100, 125, 125, 125], :cell_style=>cellstyle , position: 0) do
			column(1).style :align => :right 
			column(2).style :align => :right, :inline_format => true
			column(3).style :align => :right, :inline_format => true
		end

		# h 20

	end


	def print_games(participant)
		arr = games_array(participant)

		pdf.table( arr, :column_widths => [100,10,100,10, 25, 10, 25, 15], :cell_style=>cellstyle , position: 0) do
			column(7).style :align => :right
			rows([0,7,14,21,28,35,42, 49, 56, 63, 70, 77]).style :font_style=> :bold	
		end

	end

	def print_poule_ranking(participant)

		arr = poule_ranking_array(participant)

		pdf.table( arr, :column_widths => [25, 100, 25, 25,100, 25, 100, 25 ,25], :cell_style=>cellstyle , position: 0) do
			column(0).style :font_style=> :bold
			column(5).style :font_style=> :bold

			column(3).style :align => :right
			column(8).style :align => :right
			
			row(-1).style :font_style=> :bold
		end
	end


	def print_sixteenfinalists(participant)
		arr = sixteenfinalists_array(participant)
	
		pdf.table( arr, :column_widths => [80, 80, 25], :cell_style=>cellstyle , position: 310) do
			column(2).style :align => :right
			column(0).style :font_style=> :bold
			row(-1).style :font_style=> :bold
		end

	end

	def print_eigthfinalists(participant)
		arr = eigthfinalists_array(participant)
	
		pdf.table( arr, :column_widths => [80, 80, 25], :cell_style=>cellstyle , position: 310) do
			column(2).style :align => :right
			column(0).style :font_style=> :bold
			row(-1).style :font_style=> :bold
		end

	end

	def print_quarterfinalists(participant)
		arr = quarterfinalists_array(participant)

		
		pdf.table( arr, :column_widths => [80, 80, 25], :cell_style=>cellstyle , position: 310) do
			column(2).style :align => :right
			column(0).style :font_style=> :bold
			row(-1).style :font_style=> :bold
		end

	end

	def print_semifinalists(participant)
		arr = semifinalists_array(participant)

		
		pdf.table( arr, :column_widths => [80, 80, 25], :cell_style=>cellstyle , position: 310) do
			column(2).style :align => :right
			column(0).style :font_style=> :bold	
			row(-1).style :font_style=> :bold
		end

	end

	def print_finalists(participant)
		arr = finalists_array(participant)

		
		pdf.table( arr, :column_widths => [80, 80, 25], :cell_style=>cellstyle , position: 310) do
			column(2).style :align => :right
			column(0).style :font_style=> :bold
			row(-1).style :font_style=> :bold
		end

	end


	def print_winner(participant)
		arr = winner_array(participant)

		pdf.table( arr, :column_widths => [80, 80, 25], :cell_style=>cellstyle , position: 310) do
			column(2).style :align => :right
			column(0).style :font_style=> :bold	
		end

	end

	def print_topplayer(participant)
		arr = topplayer_array(participant)

		pdf.table( arr, :column_widths => [80, 80, 25], :cell_style=>cellstyle , position: 310) do
			column(2).style :align => :right
			column(0).style :font_style=> :bold	
		end
	end

	def print_topscorer(participant)


		arr = topscorer_array(participant)

		pdf.table( arr, :column_widths => [80, 80, 25], :cell_style=>cellstyle , position: 310) do
			column(2).style :align => :right
			column(0).style :font_style=> :bold	
		end
	end

	def print_redcard(participant)
		arr = redcard_array(participant)

		pdf.table( arr, :column_widths => [80, 80, 25], :cell_style=>cellstyle , position: 310) do
			column(2).style :align => :right
			column(0).style :font_style=> :bold	

		end
	end

	def print_score(participant)
		arr = score_array(participant)

		pdf.table( arr, :column_widths => [80, 80, 25], :cell_style=>cellstyle , position: 310) do
			column(2).style :align => :right
			row(0).style :font_style=> :bold	
		end	
	end
end