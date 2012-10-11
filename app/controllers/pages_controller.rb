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
	end

	def test2
		app = FbGraph::Application.new("154291521379396")
		me = FbGraph::User.me(current_user.access_token)
		actions = me.og_actions 'bitehook:attend'
		action = me.og_action!(
			'bitehook_offline:attend',
			event: 'http://bitehook.com/test'
		)
	end
end