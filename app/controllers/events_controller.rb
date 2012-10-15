class EventsController < ApplicationController
	before_filter :authenticate, except: [:show, :permalink]
	before_filter :admin_user, except: [:attend, :show, :permalink, :upcoming]

	# all users
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

	def attend
		event = Event.find(params[:id])
		unless Attendance.find_by_user_id_and_event_id(current_user, event)
			Attendance.create(user_id: current_user.id, event_id: event.id)
		end
		fb_action('attend', event).delay(queue: 'attend', priority: 9) if Rails.env.production?
		respond_to do |format|
			format.html {
				flash[:success] = 'Thank you for attending, see you there!'
				redirect_to event
			}
			format.js {
				@event = event
			}
		end
	rescue ActiveRecord::RecordNotFound
		redirect_to upcoming_path
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
			@events = Event.order(:name).where("name ILIKE ? OR info ILIKE ?", "%#{params[:term]}%", "%#{params[:term]}%")
		else
			@events = Event.order(:name).where("name LIKE ? OR price LIKE ? OR date LIKE ? OR info LIKE ? OR address_1 LIKE ? OR address_2 LIKE ? OR city LIKE ? OR state LIKE ? OR zip_code LIKE ?", "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%")
		end
		render json: @events.map(&:name)
	end
end