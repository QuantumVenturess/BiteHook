class EventsController < ApplicationController
	before_filter :authenticate, except: :show
	before_filter :admin_user, except: [:upcoming, :show]
	
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
		@attending = @event.users
		@comments = @event.comments
	rescue ActiveRecord::RecordNotFound
		redirect_to upcoming_path
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