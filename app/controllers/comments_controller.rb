class CommentsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_comment_owner, only: [:destroy]
	#NOTE: No need to check for banned user, since comments are
	#embedded in post and profile views which already check if banned

	def create
		@comment = @commentable.comments.build(comment_params)
		@comment.user_id = current_user.id
		if @comment.save
			flash[:success] = "Successfully added comment."
			redirect_to @commentable
		else
			flash[:error] = "Unable to add comment."
			redirect_to @commentable
		end
	end


	def destroy
		@comment = Comment.find(params[:id])
		if @comment.destroy
			flash[:notice] = 'Comment was successfully deleted.'
			redirect_to root_url
		end
	end

	def show
	end

	private
		
		def comment_params
			params.require(:comment).permit(:body, :user_id)
		end
end
