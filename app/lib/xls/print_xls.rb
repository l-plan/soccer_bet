
module PrintXls
	require 'spreadsheet'


	def save_to_stream

		io = StringIO.new
		xls.write io
		io.rewind

		io
	end

	def date_format
		Spreadsheet::Format.new :number_format => 'DD/MM/YYYY'
	end

	def time_format
		Spreadsheet::Format.new :number_format => 'hh:mm'
	end

	def number_format
		Spreadsheet::Format.new :number_format => "#,##0.00"
	end

	


end
