class SessionsController < ApplicationController
  include SessionsHelper

	#Render the login page
	def new
		render 'new'
	end

	#Create a new session, log in
	def create
		user = User.find_by(email: params[:session][:email].downcase)
		#Correct Login Parameters
		if user && user.authenticate(params[:session][:password])
			#User Activated
			if user.activated?
				flash.now[:success] = "Sucessful log in."
				#Remember Password Selected
				if params[:session][:remember_me] == '1'
					remember(user)
				else
					forget(user)
				end
				log_in user
				remember user
				redirect_to root_url
			#User not Activated
			else
				message = "Account not activated. Check your email for the activation link."
				flash[:error] = message
				redirect_to root_url
			end
		#incorrect login paramaters
		else
			flash.now[:error] = "Invalid email/password combination"
			render 'new'
		end
	end

	#Log a user out
	def destroy
		flash[:success] = "Successful log out."
		log_out if logged_in?
		redirect_to root_url
	end
end
