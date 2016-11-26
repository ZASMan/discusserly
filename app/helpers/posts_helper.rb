module PostsHelper
	
	#Redirects user from edit/update/destroy page unless 
	#They are an admin or post owner
	def correct_post_owner
		@post = Post.find(params[:id])
		unless current_user.admin?
			if current_user.id != @post.user_id
				redirect_to(root_url)
				flash[:error] = "Sorry, you don't have permission to do that."
			end
		end
	end
end
