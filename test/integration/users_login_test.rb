require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

	#Users corresponds to the fixture filename users.yml in test/fixtures/users.yml
	#with test_user referring to the user key
	def setup
		@user = users(:test_user)
		@unconfirmed_user = users(:unconfirmed_test_user)
	end

	test "login with invalid information" do
		get login_path
		assert_template 'sessions/new'
		post login_path, params: { session: { email: " " , password: " " } }
		assert_template 'sessions/new'
	end

	test "login with valid information followed by logout" do
		get login_path
		post login_path, params: {session: { email: @user.email, password: 'password'}}

		assert is_logged_in?
		assert_redirected_to @user
		follow_redirect!
		assert_template 'users/show'
		assert_select 'a[href=?]', login_path, count: 0
		assert_select 'a[href=?]', logout_path
		assert_select 'a[href=?]', edit_user_path(@user)
		delete logout_path
		assert_not is_logged_in?
		assert_redirected_to root_url
		follow_redirect!
		assert_select 'a[href=?]', login_path
		assert_select 'a[href=?]', logout_path, count: 0
	end
	
	test "login as unconfirmed user" do
		get login_path
		assert_template 'sessions/new'
		post login_path, params: { session: { email: @unconfirmed_user.email, password: 'password' }}
		assert_redirected_to root_url
	end

end
