class UsersController < ApplicationController
	before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
	before_action :correct_user, only: [:edit, :update]
	before_action :admin_user, only: :destroy

	def index
		#@users = User.paginate(page: params[:page])
		@users = User.where(activated: true).paginate(page: params[:page])
	end

	def new
		@user = User.new
		render "new"
	end


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
		if @user.activated?
			render 'show'
		else
			redirect_to root_url
		end
	end

	def edit
		@user = User.find(params[:id])
		render 'edit'
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			flash.now[:success] = "Your settings have been successfully updated"
			redirect_to @user
		else
			render 'edit'
		end
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "User deleted"
		redirect_to users_url
	end

	private

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end

	#Before Filters

	#Confirms a logged-in user
	def logged_in_user
		unless logged_in?
			flash[:danger] = "Please log in."
			redirect_to login_url
		end
	end

	#Confirms the correct user
	def correct_user
		@user= User.find(params[:id])
		redirect_to(root_url) unless current_user?(@user)
	end

	#Confirms admin user
	def admin_user
		redirect_to(root_url) unless current_user.admin?
	end
end
