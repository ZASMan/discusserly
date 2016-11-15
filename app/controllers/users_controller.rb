class UsersController < ApplicationController
	before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
	before_action :correct_user, only: [:edit, :update]
	before_action :admin_user, only: :destroy
	before_action :already_logged_in, only: [:new, :create]
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
		render "new"
	end

	#Users will be redirected if attempting to use the signup page while logged in
	def create
		#Instance Variable for user object being equal to user_params
		@user = User.new(user_params)
		if @user.save
			@user.send_activation_email
			redirect_to root_url
			flash.now[:notice] = "Thank you for signing up!"
		else
			flash.now[:danger] = "Please enter a valid e-mail address and a matching password and password confirmation. Your password must contain 8 or more characters, a digit (0-9), at least one lower case character, at least one upper case character, and a symbol."
			render "new"
		end
	end


	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
		render 'edit'
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			flash.now[:success] = "Your settings have been successfully updated."
			redirect_to @user
		else
			render 'edit'
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
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end

	#For redirecting users who are already authenticated to their own profile page
	def already_logged_in
		#current user is not nil
		if !current_user.nil?
			redirect_to user_path(current_user.id)
		end
	end
end
