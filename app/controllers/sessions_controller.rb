class SessionsController < ApplicationController
  #Render the login page
	def new
  end

	#Create a new session, log in
	def create
		user = User.find_by(email: params[:email])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to root_url, notice: "Successful log in."
		else
			flash.now.alert = "Invalid email/password combination."
			render :new
		end
	end

	#Log a user out
	def destroy
		session[:user_id] = nil
		redirect_to root_url, notice: "Successful log out."
	end
end
