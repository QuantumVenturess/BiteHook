class CommentsController < ApplicationController
	before_filter :authenticate

	def create
		comment = current_user.comments.create(params[:comment])
		if comment.save
			respond_to do |format|
				format.html {
					flash[:success] = 'Comment created'
					redirect_to Event.find(comment.event_id)
				}
				format.js {
					@comment = comment
					@event = comment.event
				}
			end
			if params[:post_facebook] == '1'
				api_call = HTTParty.get("https://graph.facebook.com/me/permissions?access_token=#{current_user.access_token}")
				results = JSON.parse(api_call.to_json)
				if results['data'][0]['publish_stream'] == 1
					app = FbGraph::Application.new(app_id)
					me  = FbGraph::User.me(current_user.access_token)
					if Rails.env.production?
						action = me.og_action!(
							'bitehook:comment_on',
							event: "http://bitehook.com/events/#{comment.event_id}/permalink"
						)
					end
				end
			end
		else
			flash[:error] = 'Comment was not created'
			redirect_to :back
		end
	end

	def destroy
		comment = Comment.find(params[:id])
		respond_to do |format|
			format.html {
				if comment.user == current_user || current_user.admin?
					flash[:success] = 'Comment deleted'
				else
					flash[:error] = 'You can only delete your comment'
				end
				redirect_to :back
			}
			format.js {
				@comment = comment
			}
		end
		comment.destroy if comment.user == current_user || current_user.admin?
	end
end