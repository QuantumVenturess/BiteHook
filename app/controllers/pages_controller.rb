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
		@user = current_user
		@event = Event.first
		@title = @event.name
		@attending = @event.users
		@comments = @event.comments
		app = FbGraph::Application.new("154291521379396")
		me = FbGraph::User.me(current_user.access_token)
		action = me.og_action!(
			'bitehook_offline:attend',
			event: 'http://bitehook.com/test2'
		)
	end

	def test2
		@user = current_user
		@event = Event.first
		@title = @event.name
		@attending = @event.users
		@comments = @event.comments
		render layout: false
	end
end