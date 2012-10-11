class PaymentsController < ApplicationController
	before_filter :authenticate
	before_filter :admin_user, only: :index

	def index
		@title = 'All Payments'
		@payments = Payment.order('created_at DESC')
	end

	def confirm_payment
		event = Event.find_by_id(params[:event_id])
		event_id = event ? event.id : nil
		payment = Payment.new(user_id: current_user.id,
							  event_id: event_id,
							  amount: params[:transactionAmount].split(' ')[1].to_f,
							  transaction_id: params[:transactionId],
							  description: params[:paymentReason])
		if event
			if payment.save!
				if payment.amount == event.price
					unless Attendance.find_by_user_id_and_event_id(current_user, event)
						Attendance.create(user_id: current_user.id, event_id: event.id)
					end
					if Rails.env.production?
						app = FbGraph::Application.new(app_id)
						me = FbGraph::User.me(current_user.access_token)
						action = me.og_action!(
							'bitehook:attend',
							event: event_path(comment.event)
						)
					end
#					api_call = HTTParty.get("https://graph.facebook.com/me/permissions?access_token=#{current_user.access_token}")
#					results = JSON.parse(api_call.to_json)
#					if results['data'][0]['publish_stream'] == 1
#						me = FbGraph::User.me(current_user.access_token)
#						me.feed!(
#							message: "Going to the #{event.name}, see you there.",
#							picture: event.image1,
#							link: "http://bitehook.com#{event_path(event)}",
#							name: "BiteHook: #{event.name}",
#							description: event.info
#						)
					end
					flash[:success] = 'Payment received. See you at the event!'
				else
					flash[:notice] = 'You may have paid too much or too little. Please contact us regarding this issue.'
				end
			else
				flash[:error] = 'Payment was not processed, please try again.'
			end
			redirect_to event
		else
			if payment.save
				flash[:notice] = 'You have paid for an unknown event. Please contact us regarding this issue.'
			else
				flash[:error] = 'Payment was not processed, please try again.'
			end
			redirect_to upcoming_path
		end
	end
end