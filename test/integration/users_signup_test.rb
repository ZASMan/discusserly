require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
	
	def setup
		ActionMailer::Base.deliveries.clear
		@user = users(:test_user)
	end
	
	test "invalid signup information" do
		get signup_path
		#TODO: Must also assert that profile count does not increase by 1
		assert_no_difference 'User.count' do
			post users_path, params: {user: { name: "", email: "user@invalid",
																				password: "foo",
																				password_conirmation: "bar"}}
		end
		assert_redirected_to signup_path
	end

	#Please make note to the PASSWORD_FORMAT in app/models/user.rb
	test "valid signup information" do
		get signup_path	
		assert_difference 'User.count', 1 do
			post users_path, params: {user: { name: "Example User", email: "user@example.com",
																				password: "Foobar#1",
																				password_confirmation: "Foobar#1"}}
		end
		#TODO: Must also assert profile count increase
		#Assert Email Delivery
		assert_equal 1, ActionMailer::Base.deliveries.size
		#Assigns method allows us to access instance avariables in corresponding action
		user = assigns(:user)
		assert_not user.activated?
		#Try to log in before activation
		log_in_as(user)
		assert_not is_logged_in?
		#Invalid activation token
		get edit_account_activation_path("invalid token", email: user.email)
		assert_not is_logged_in?
		#Valid token, wrong email,
		get edit_account_activation_path(user.activation_token, email: 'wrong')
		assert_not is_logged_in?
		#Valid activation token
		get edit_account_activation_path(user.activation_token, email: user.email)
		assert user.reload.activated?
		follow_redirect!
		assert_template 'users/show'
		assert is_logged_in?
	end

	test "authenticated users cannot view the signup page and will be redirected to own url" do
		get login_path
		post login_path, params: {session: { email: @user.email, password: 'password' }}
		assert is_logged_in?
		assert_redirected_to root_url
		follow_redirect!
		get signup_path
		assert_redirected_to root_url
	end
end
