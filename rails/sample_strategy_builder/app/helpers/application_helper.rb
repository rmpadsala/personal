module ApplicationHelper
	def full_title(page_title)
	  base_title = "AlgoFast Sample Strategy Builder App"
	  if page_title.empty?
	    base_title
	  else
	    "#{base_title} | #{page_title}"
	  end
	end	

	def current_local_time
		Time.zone.now.strftime('%m/%d/%Y %I:%M:%S %p')
	end

	def current_year
		Time.now.strftime('%Y')
	end
end
