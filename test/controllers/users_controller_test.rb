require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest


	def setup
		@user = users(:test_user)
		@second_user = users(:second_test_user)
	end

	test 'should redirect edit when logged in as the wrong user' do
		log_in_as(@second_user)
		get edit_user_path(@user)
		assert_redirected_to root_url
	end

	test 'should redirect when logged in as wrong user' do
		log_in_as(@second_user)
		patch user_path(@user), params: { user: { email: @user.email}}
		assert_redirected_to root_url
	end

	test "should redirect index when not logged in" do
		get users_path
		assert_redirected_to login_url
	end

	test "should not allow the admin attribute to be edited online" do
		log_in_as(@second_user)
		assert_not @second_user.admin?
		patch user_path(@second_user), params: {
																		user: { password: :password,
																						password_confirmation: :password_confirmation,
																						admin: true } }
		assert_not @second_user.admin?
	end

	test "should redirect destroy when not logged in" do
		assert_no_difference 'User.count' do
			delete user_path(@user)
		end
		assert_redirected_to login_url
	end

	test 'should redirect destroy when logged in as a non-admin' do
		log_in_as(@second_user)
		assert_no_difference 'User.count' do
			delete user_path(@user)
		end
		assert_redirected_to root_url
	end
end
