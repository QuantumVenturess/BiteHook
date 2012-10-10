module ApplicationHelper

	def title
		@title ? @title : "BiteHook"
	end
	
	def to_html(str)
		simple_format h(str)
	end
end