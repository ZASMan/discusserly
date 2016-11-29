module CommentsHelper

	#Doesn't allow user to delete unless they are comment creator
	def correct_comment_owner
		@comment = Comment.find(params[:id])
		unless current_user.admin?
			if current_user.id != @comment.user_id
				redirect_to(root_url)
				flash[:error] = "Sorry, you don't have permission to do that."
			end
		end
	end
end
