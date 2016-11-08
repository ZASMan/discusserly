class UsersController < ApplicationController

	def new
		@user = User.new
		respond_to do |format|
			format.html{ render "new.html.haml", layout: "application.html.erb"
		end
	end


	def create
		#Instance Variable for user object being equal to user_params
		@user = User.new(user_params)
		if @user.save
			#Need a method to log user in on sign up	
			log_in @user
			redirect_to @user
			flash.now[:notice] = "Thank you for signing up!"
		else
			flash.now[:danger] = "Please enter a valid e-mail address and a matching password and password confirmation with at least 6 characters."
			respond_to do |format|
				format.html { render "new.html.haml", layout: "application.html.erb"
		end
	end


	def show
		@user = User.find(params[:id])
		respond_to do |format|
			format.html {render "show.html.haml", layout: "application.html.erb"}
		end
	end

	def edit
		@user = User.find(params[:id])
		respond_to do |format|
			format.html {render "edit.html.haml", layout: "application.html.erb"}
		end
	end

	private

	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation)
	end

end
