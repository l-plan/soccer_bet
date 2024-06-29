module Pdf::ParticipantHelper
	include ::ParticipantsHelper


	def print_participant_page(participant)
		print_participant_header(participant)

		print_games(participant)

		h -601

		print_eigthfinalists(participant)

		print_quarterfinalists(participant)

		print_semifinalists(participant)

		print_finalists(participant)

		print_winner(participant)

		print_topplayer(participant)

		print_topscorer(participant)

		print_redcard(participant)

		print_poule_ranking(participant)

		h 50

		print_score(participant)
	end

	def print_participant_header(participant)

		arr = participant_header_array(participant)

		pdf.table( arr, :column_widths => [100, 125], :cell_style=>cellstyle , position: 0) do
			column(1).style :align => :right 
		end

		h 20

	end


	def print_games(participant)
		arr = games_array(participant)

		pdf.table( arr, :column_widths => [60,10,60,10, 25, 10, 25, 25], :cell_style=>cellstyle , position: 0) do
			column(7).style :align => :right
			rows([0,7,14,21,28,35,42]).style :font_style=> :bold	
		end

	end

	def print_poule_ranking(participant)
		h 100
		arr = poule_ranking_array(participant)
	
		pdf.table( arr, :column_widths => [100, 25, 25, 25], :cell_style=>cellstyle , position: 0) do
			# column(2).style :align => :right
			column(0).style :font_style=> :bold
			row(-1).style :font_style=> :bold
		end

	end

	def print_eigthfinalists(participant)
		arr = eigthfinalists_array(participant)
	
		pdf.table( arr, :column_widths => [80, 80, 25], :cell_style=>cellstyle , position: 300) do
			column(2).style :align => :right
			column(0).style :font_style=> :bold
			row(-1).style :font_style=> :bold
		end

	end

	def print_quarterfinalists(participant)
		arr = quarterfinalists_array(participant)

		h 10
		pdf.table( arr, :column_widths => [80, 80, 25], :cell_style=>cellstyle , position: 300) do
			column(2).style :align => :right
			column(0).style :font_style=> :bold
			row(-1).style :font_style=> :bold
		end

	end

	def print_semifinalists(participant)
		arr = semifinalists_array(participant)

		h 10
		pdf.table( arr, :column_widths => [80, 80, 25], :cell_style=>cellstyle , position: 300) do
			column(2).style :align => :right
			column(0).style :font_style=> :bold	
			row(-1).style :font_style=> :bold
		end

	end

	def print_finalists(participant)
		arr = finalists_array(participant)

		h 10
		pdf.table( arr, :column_widths => [80, 80, 25], :cell_style=>cellstyle , position: 300) do
			column(2).style :align => :right
			column(0).style :font_style=> :bold
			row(-1).style :font_style=> :bold
		end

	end


	def print_winner(participant)
		arr = winner_array(participant)

		pdf.table( arr, :column_widths => [80, 80, 25], :cell_style=>cellstyle , position: 300) do
			column(2).style :align => :right
			column(0).style :font_style=> :bold	
		end

	end

	def print_topplayer(participant)
		arr = topplayer_array(participant)

		pdf.table( arr, :column_widths => [80, 80, 25], :cell_style=>cellstyle , position: 300) do
			column(2).style :align => :right
			column(0).style :font_style=> :bold	
		end
	end

	def print_topscorer(participant)
		arr = []
		player = participant.players.find{|x| x.stage=="topscorer"}
		arr << ["topscorer",player.player.name, player.score.to_s]

		pdf.table( arr, :column_widths => [80, 80, 25], :cell_style=>cellstyle , position: 300) do
			column(2).style :align => :right
			column(0).style :font_style=> :bold	
		end
	end

	def print_redcard(participant)
		arr = redcard_array(participant)

		pdf.table( arr, :column_widths => [80, 80, 25], :cell_style=>cellstyle , position: 300) do
			column(2).style :align => :right
			column(2).style :font_style=> :bold	

		end
	end

	def print_score(participant)
		arr = score_array(participant)

		pdf.table( arr, :column_widths => [80, 80, 25], :cell_style=>cellstyle , position: 300) do
			column(2).style :align => :right
			row(0).style :font_style=> :bold	
		end	
	end
end