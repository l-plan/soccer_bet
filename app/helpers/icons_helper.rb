module IconsHelper
		# def homeLink
		# 	'<i class="fas fa-home fa-lg" style="color:grey;margin-top:-5px"></i>'.html_safe
		# end

		# def userLink
		# 	'<i class="fas fa-user" style="color:grey"></i>'.html_safe
		# end

		# def addIcon
		# 	# '<i class="fa fa-home fa-lg" style="color:grey"></i>'.html_safe
		# 	'<i class="fa fa-file-plus" style="color:grey"></i>'.html_safe
		# end


		def succesIcon
			content_tag(:i, nil, class: "bi bi-check-lg", style: "font-size: 2em; color:green" )
		end

		def editIcon
			'<i class="bi bi-pencil-square" style="color:grey"></i>'.html_safe
		end

		def showIcon
			'<i class="bi bi-eye" style="color:grey"></i>'.html_safe
		end

		# def indexIcon
		# 	'<i class="fal fa-list-ul" style="color:grey"></i>'.html_safe
		# end

		def destroyIcon
			'<i class="bi bi-trash3" style="color:grey"></i>'.html_safe
		end

		def iconCheck?(val, options={})
			val ? iconCheck(options) : iconSquare(options)
		end

		def iconSquare(options={})
			size = options[:size] || 1
			content_tag(:i, nil, class: "bi bi-x-square", style: "font-size: #{size}em; color:grey" )
		end

		def iconCheck(options={})
			size = options[:size] || 1
			content_tag(:i, nil, class: "bi bi-check-square", style: "font-size: #{size}em; color:green" )
		end

		# def pdfIcon
		# 	'<i class="fal fa-file-pdf fa-lg"  style="color:red"></i>'.html_safe
		# end

		# def badgeCheck?(val)
		# 	val ? badgeCheck : badgeUncheck
		# end

		# def badgeCheck
		# 	'<i class="fas fa-badge-check" style="color:green"></i>'.html_safe
		# end

		# def badgeUncheck
		# 	'<i class="fal fa-badge"></i>'.html_safe
		# end

end
