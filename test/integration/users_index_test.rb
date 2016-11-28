require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

	def setup
		location = Faker::Address.city.capitalize + ", " + Faker::Address.country.capitalize
		occupation = Faker::Company.profession.capitalize
		about_me = Faker::Hipster.paragraph
		image_url = Faker::Avatar.image("my-own-slug", "50x50", "bmp", "set1", "bg1")
		#Users
		@admin_user = users(:test_user)
		@non_admin = users(:second_test_user)
		@unconfirmed_user = users(:unconfirmed_test_user)
		@banned_user = users(:banned_user)
		#Profiles
		@admin_user_profile = @admin_user.create_profile(location: location, occupation: occupation, about_me: about_me, image_url: image_url)
		@non_admin_profile = @non_admin.create_profile(location: location, occupation: occupation, about_me: about_me, image_url: image_url)
		@unconfirmed_user_profile = @unconfirmed_user.create_profile(location: location, occupation: occupation, about_me: about_me, image_url: image_url)
		@banned_user_profile = @banned_user.create_profile(location: location, occupation: occupation, about_me: about_me, image_url: image_url)
	end

	test "for admin index includes pagination and delete links" do
		log_in_as(@admin_user)
		get users_path
		assert_template 'users/index'
		assert_select 'div.pagination'
		first_page_of_users = User.paginate(page: 1)
		first_page_of_users.each do |user|
			#Only activated users appear on the index
			if user.activated?
				assert_select 'h5', text: user.name
			end
			unless user == @admin_user
				assert_select 'a', text: 'Delete'
			end
		end
		assert_difference 'User.count', -1 do
			delete user_path(@non_admin)
		end
	end

	test "index as non-admin" do
		log_in_as(@non_admin)
		get users_path
		assert_select 'a', text: 'delete', count: 0
	end

	test "banned user redirected to forbidden path" do
		log_in_as(@banned_user)
		get users_path
		assert_redirected_to forbidden_path
	end
end
