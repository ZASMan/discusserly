require 'test_helper'

class ProfileShowTest < ActionDispatch::IntegrationTest

	def setup
		#Users
		#Name is 'Test User'
		@admin_user = users(:test_user)
		#Profiles
		@admin_user_profile = @admin_user.create_profile(location: "America", occupation: "Doctor", about_me: "I am a guy", image_url: 'wikipedia.orgi')
	end

	test "profile show page contains all expected elements" do
		log_in_as(@admin_user)
		get profile_path(@admin_user.profile)
		#Name
		assert_select 'h1', text: 'Test user'
		#Image
		assert_select 'img'
		#Location
		assert_select 'h5', text: 'America'
		#About Me
		assert_select 'h5', text: 'Doctor'
	end
end
