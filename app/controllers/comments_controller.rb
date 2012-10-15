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
			fb_action('comment_on', comment.event).delay(queue: 'comment_on', priority: 10) if Rails.env.production?
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