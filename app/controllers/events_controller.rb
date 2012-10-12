class EventsController < ApplicationController
	before_filter :authenticate, except: [:attend, :show, :permalink]
	before_filter :admin_user, except: [:attend, :show, :permalink, :upcoming]

	# all users
	def attend
		event = Event.find(params[:id])
		api_call = HTTParty.get("https://graph.facebook.com/me/permissions?access_token=#{current_user.access_token}")
		results = JSON.parse(api_call.to_json)
		if results['data'][0]['publish_stream'] == 1
			app = FbGraph::Application.new(app_id)
			me  = FbGraph::User.me(current_user.access_token)
			if Rails.env.production?
				action = me.og_action!(
					'bitehook:attend_the',
					event: "http://bitehook.com#{event_path(event)}/permalink"
				)
			end
		end
		flash[:success] = 'Thank you for attending, see you there!'
		redirect_to event
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

	# signed in users
	def upcoming
		@title = 'Upcoming Events'
		@events = Event.where('date >= ?', Time.now).order('date ASC')
		render 'index'
	end

	# admin users
	def index
		@title = 'All Events'
		@events = Event.order('date DESC')
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

	def event_list
		if Rails.env.production?
			@events = Event.order(:name).where("name ILIKE ? OR price ILIKE ? OR date ILIKE ? OR info ILIKE ? OR address_1 ILIKE ? OR address_2 ILIKE ? OR city ILIKE ? OR state ILIKE ? OR zip_code ILIKE ?", "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%")
		else
			@events = Event.order(:name).where("name LIKE ? OR price LIKE ? OR date LIKE ? OR info LIKE ? OR address_1 LIKE ? OR address_2 LIKE ? OR city LIKE ? OR state LIKE ? OR zip_code LIKE ?", "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%")
		end
		render json: @events.map(&:name)
	end
end