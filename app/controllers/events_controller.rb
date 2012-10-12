class EventsController < ApplicationController
	before_filter :authenticate, except: [:show, :permalink]
	before_filter :admin_user, except: [:upcoming, :show, :permalink]

	def attend
		event = Event.find(params[:id])
		if params[:post_facebook] == '1'
			api_call = HTTParty.get("https://graph.facebook.com/me/permissions?access_token=#{current_user.access_token}")
			results = JSON.parse(api_call.to_json)
			if results['data'][0]['publish_stream'] == 1
				app = FbGraph::Application.new(app_id)
				me  = FbGraph::User.me(current_user.access_token)
				if Rails.env.production?
					action = me.og_action!(
						'bitehook:attend',
						event: "http://bitehook.com#{event_path(event)}/permalink"
					)
				end
			end
		end
		flash[:success] = 'Thank you for attending, see you there!'
		redirect_to event
	end
	
	def upcoming
		@title = 'Upcoming Events'
		@events = Event.where('date >= ?', Time.now).order('date ASC')
		render 'index'
	end

	def index
		@title = 'All Events'
		@events = Event.order('date DESC')
	end

	def show
		@event = Event.find(params[:id])
		@title = @event.name
		@attending = @event.users.shuffle
		@comments = @event.comments
		store_location
	rescue ActiveRecord::RecordNotFound
		redirect_to upcoming_path
	end

	def permalink
		@event = Event.find(params[:id])
		render layout: false
	end

	def new
		@title = 'New Event'
		@event = Event.new
	end

	def create
		@event = Event.new(params[:event])
		if @event.save
			flash[:success] = 'Event created'
			redirect_to @event
		else
			@title = 'New Event'
			render 'new'
		end
	end

	def edit
		@event = Event.find(params[:id])
		@title = 'Edit Event'
		render 'new'
	end

	def update
		@event = Event.find(params[:id])
		if @event.update_attributes(params[:event])
			flash[:success] = 'Event updated'
			redirect_to @event
		else
			@title = 'Edit Event'
			render 'new'
		end
	end

	def destroy
		Event.find(params[:id]).destroy
		flash[:success] = 'Event deleted'
		redirect_to events_path
	end
end