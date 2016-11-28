class CommentsController < ApplicatioinController
	def create
		if params[:post_id]
			@parent = Post.find(params[:post_id])
		elsif params[:profile_id]
			@parent = Profile.find(params[:profile_id])
		end
		@comment = @parent.comments.build(comment_params)
		@comment.user = current_user
		if @comment.save
			if @parent.is_a?(Post)
				flash[:notice] = 'Comment saved successfully.'
				redirect_to @parent
			elsif @parent.is_a?(Profile)
				flash[:notice] = 'Comment saved successfully.'
				redirect_to @parent
			end
		end
	end


	def destroy
		comment = Comment.find(params[:id])
		if comment.destroy
			flash[:notice] = 'Comment was successfully deleted.'
			redirect_to :back
		else
			flash[:alert] = "Comment couldn't be deleted. Try again."
			redirect_to :back		
		end
	end

	private
		
		def comment_params
			params.require(:comment).permit(:body)
		end
end
