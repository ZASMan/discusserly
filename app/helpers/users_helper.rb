module UsersHelper

	def logged_in_user
		unless logged_in?
			flash[:danger] = "Please log in"
			redirect_to login_url
		end
	end

	#Confirms correct user
	def correct_user
		@user = User.find(params[:id])
		redirect_to(root_url) unless current_user?(@user)
	end

	#Confirms admin user
	def admin_user
		redirect_to(root_url) unless current_user.admin?
	end
end
