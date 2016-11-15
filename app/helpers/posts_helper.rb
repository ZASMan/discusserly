module PostsHelper
	
	#Redirects viewer from edit/update/destroy page unless 
	#They are an admin or post owner
	def correct_post_owner
		@post = Post.find(params[:id])
		unless current_user.admin?
			redirect_to(root_url) unless current_user.id = @post.user_id
		end
	end
	

end
