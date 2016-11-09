class SessionsController < ApplicationController
  include SessionsHelper

	#Render the login page
	def new
  	respond_to do |format|
			format.html { render "new.html.haml", layout: "application.html.erb"}
		end
	end

	#Create a new session, log in
	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			flash.now[:success] = "Sucessful log in."
			if params[:session][:remember_me] == '1'
				remember(user)
			else
				forget(user)
			end
			log_in user
			remember user
			redirect_to user
		else
			respond_to do |format|
				flash.now[:error] = "Invalid email/password combination."
				format.html {render "new.html.haml", layout: "application.html.erb"}
			end
		end
	end

	#Log a user out
	def destroy
		flash[:success] = "Successful log out."
		log_out if logged_in?
		redirect_to root_url
	end
end
