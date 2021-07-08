require 'prawn'
require 'prawn/table'
require 'prawn/icon'


module Pdf::PrintPdf
	
	Prawn::Font::AFM.hide_m17n_warning = true

	include ActiveSupport::NumberHelper
	include ApplicationHelper


	attr_reader :pdf
	

# Prawn.debug = true



	def defaults
			{
	    	:page_size=>'A4',
			:page_layout=>:portrait,# or :landscape	
			:left_margin=>60,
			:right_margin=>60,	
			:top_margin	=>50,
			:bottom_margin=>60,
			:font_size=> 7

			}


			# :margin,
			# :skip_page_creation,
			# :compress,
			# :background,
			# :info,
			# :text_formatter,
			# :print_scaling


	end

	def h(options=nil)
		pdf.move_down options.to_i
		pdf.cursor
	end


	def logo2014
		Rails.root.join('app/assets/images/logo_trans_2014.png')
	end



	def save
		pdf.render_file name
	end

	def footerlogo
		pdf.repeat(:all) do
			pdf.image logo2014 ,width: 30, height: 6, :at=>[20,0]
			pdf.draw_text "\u00A9", :at => [0, -5], :size=>6
			pdf.draw_text "verzorgd door l-plan", :at => [200, -5], :size=>6
		end
	end




	def page_numbers

		string = "pagina <page> van <total>"

		options = { :at => [pdf.bounds.right - 150, 0],
		              :width => 150,
		              :align => :right,
		              # :page_filter => (1..7),
		              :start_count_at => 1,
		              # :color => "007700"
		              :size=>6
		               }
         pdf.number_pages string, options

	end

	def footer_with_page_numbers
		page_numbers
		footerlogo
	end
	


	private



	def cellstyle
		{:height=> 14, :padding => [0, 0, 0, 5], :border_width=> 0, :size => 7 }
	end

	def reference_style
		{:font_style=> :italic, :size=>7 , :height=>20, :border_width=> 0 }
	end

	def bold_style
		{:font_style=> :bold, :size=>7 , :height=>20, :border_width=> 0 }
	end

	def bolder_style
		{:font_style=> :bold, :size=>9 , :height=>25, :border_width=> 0 }
	end

	def smaller_style
		{ :size=>6 , :height=>20, :border_width=> 0 }
	end

	def vertical_style
		{:size=>7 , :valign => :bottom, :rotate => 90, :align=> :left, :height=> 50, :border_width=> 0}
	end



end
