class UsersController < ApplicationController
	before_action :logged_in_user, only: [:index, :edit, :update,:destroy]
	before_action :correct_user, only: [:edit, :update,]
	before_action :admin_user, only: :destroy
	before_action :already_logged_in, only: [:new, :create]
	#Banned users cannot see anything related to users
	before_action :check_banned_user, only: [:index, :show, :edit, :update,  :destroy]
	#Note: In the sessions controller, unconfirmed users will be
	#Automatically redirected to root_url and told to confirm email

	def index
		if current_user.activated?
			@users = User.where(activated: true).paginate(page: params[:page])
		else
			flash[:error] = "Please confirm your account  before viewing this page."
			redirect_to root_url
		end
	end

	def new
		@user = User.new
	end

	#Users will be redirected if attempting to use the signup page while logged in
	def create
		@user = User.new(user_params)
		respond_to do |format|
			if @user.save
				@user.send_activation_email	
				format.html {redirect_to root_url, notice: "Thank you for signing up! You will have received a confirmation link in your email shortly which you must click before posting."}
				#Create User Profile on Successful User Save
				@user.create_profile(location: "Add your location here.", occupation: "Add your occupation here.", about_me: "Write a little bit about yourself here!", image_url: "Add a link to a profile image here (E.G. right click image with 'copy image location' and paste here)")
			else
				format.html { redirect_to signup_path, notice: "Please enter a valid e-mail address and a matching password and password confirmation. Your password must contain 8 or more characters, a digit (0-9), at least one lower case character, at least one upper case character, and a symbol."}
			end
		end
	end


	def show
		@user = User.find(params[:id])
	end

	#This is for the account settings page
	def edit
		Rails.logger.warn("Rendering account settings page.")
		@user = User.find(params[:id])
	end

	#For account settings page
	def update
		@user = User.find(params[:id])
		respond_to do |format|
			if @user.update_attributes(user_params)
				Rails.logger.warn("Your settings have been successfully updated.")
				flash.now[:success] = "Your settings have been successfully updated."
				format.html {redirect_to @user}
			else
				Rails.logger.warn("Please be sure to fill out your email, password, and password confirmation.")
				format.html {redirect_to edit_user_path}
				flash[:error] = "Please be sure to fill out your email, password, and password confirmation."
			end
		end
	end

	#Only Admins can Destroy Users
	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "User deleted"
		redirect_to users_url
	end

	private

		def user_params
			params.require(:user).permit(:email, :password, :password_confirmation)
		end

		#For redirecting users who are already authenticated to their own profile page
		def already_logged_in
			#current user is not nil
			if !current_user.nil?
				redirect_to root_url
			end
		end

		#Must check and make sure current user is logged in AND banned
		def check_banned_user
			if !current_user.nil? && current_user.banned?
				redirect_to forbidden_path
			end
		end

end
