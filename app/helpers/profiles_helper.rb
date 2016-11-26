module ProfilesHelper

	#Redirects user from edit/update/destroy page unless
	#They are admin or profile owner
	def correct_profile_owner
		@profile = Profile.find(params[:id])
		unless current_user.admin?
			if current_user.id != @profile.user_id
				redirect_to(root_url)
				flash[:error] = "Sorry, you don't have permission to do that."
			end
		end
	end
end
