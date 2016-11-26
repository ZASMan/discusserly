class ProfilesController < ApplicationController
	before_action :logged_in_user, only: [:index, :new, :create, :edit, :update, :show, :destroy]
	before_action :correct_profile_owner, only: [:edit, :update, :destroy]
	before_action :check_banned_user, only: [:index, :new, :create, :edit, :update, :show, :destroy]
	#before_action :profile_already_created, only: [:new, :create]
	#Note: In the sessions controller, unconfirmed users will be
	#Automatically redirected to root_url and told to confirm email
	
	def new
		@profile = Profile.new
	end

	def create
		@profile = current_user.profiles.build(profile_params)
		respond_to do |format|
			if @profile.save
				#Redirect to Profile
				flash.now[:success] = "Profile successfully created."
				format.html {redirect_to @profile}
				format.json{render :show, status: :created, location: @profile }
			else
				format.html {render :new }
				flash[:error] = "Please fill out all required profile fields."
			end
		end
	end

	def edit
		@profile = Profile.find(params[:id])
	end

	def update
		@profile = Profile.find(params[:id])
		if @profile.update_attributes(profile_params)
			flash.now[:success] = 'Profile has been successfully updated'
			redirect_to @profile
		else
			render 'edit'
			flash[:error] = "Please fill out all required profile fields."
		end
	end
	
	def view_my_profile
		@current_user_id = current_user.id
		@profile_array = []
		@profiles = Profile.all
		@profiles.each do |profile|
			if profile.user_id == @current_user_id
				@profile_array.push(profile)
			end
		end
		@current_user_profile = @profile_array[0]
	end

	def show
		
	end
	
	private

		def profile_params
			params.require(:profile).permit(:occupation, :location, :about_me, :image_url)
		end

		#Check to make sure current user is logged in AND banned
		def check_banned_user
			if !current_user.nil? && current_user.banned?
				redirect_to forbidden_path
			end
		end

		#Check to see if user has already created a profile for their account
	#	def profile_already_created
	#		@current_user_id = current_user.id
	#		@profile_array = []
	#		@profiles = Profile.all
	#		@profiles.each do |profile|
	#			if profile.user_id= = @current_user_id
	#				@profile_array.push(profile)
	#			end
	#		end
	#		if @profile_array.empty?
	#			redirect_to new_profile_path
#			else
#				redirect_to root_url
#			end
#		end
end
