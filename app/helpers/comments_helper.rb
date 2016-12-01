module CommentsHelper

	#TODO: At the moment, I can't quite figure out how to get a "current profile"
	#like a "current user". So for now, the delete button for other user comments
	#won't appear on the view if its not your profile, but you can still technically
	#access the delete path
	def correct_comment_owner
		@comment = Comment.find(params[:id])
		@profiles = Profile.all
		#Don't run the check if it is an admin or profile comment
		unless current_user.admin? or @comment.commentable_type == "Profile"
			if current_user.id != @comment.user_id
				redirect_to(root_url)
				flash[:error] = "Sorry, you don't have permission to do that."
			end
		end
	end
end
