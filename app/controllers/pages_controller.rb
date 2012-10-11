class PagesController < ApplicationController
	before_filter :authenticate, only: :test
	before_filter :admin_user, only: :test

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
		@event = Event.where('date < ?', Time.now)[0]
		@title = @event.name
		@attending = @event.users
		@comments = @event.comments
	end
end