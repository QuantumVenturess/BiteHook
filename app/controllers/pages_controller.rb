class PagesController < ApplicationController

	def home
		@title = "BiteHook"
		clear_return_to
	end

	def about
		@title = "About BiteHook"
	end

	def not_found
		@title = '404 Party'
		redirect_to upcoming_path
	end

	def test
		@title = 'Test'
		@event = Event.first
		render layout: false
	end
end