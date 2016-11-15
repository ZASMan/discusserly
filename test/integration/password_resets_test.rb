require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest
	
	def setup
		ActionMailer::Base.deliveries.clear
		@user = users(:test_user)
	end

	test "password resets" do
		get new_password_reset_path
		assert_template 'password_resets/new'
		#Invalid email
		post password_resets_path, params: { password_reset: { email: "" } }
		assert_not flash.empty?
		assert_template 'password_resets/new'
		#Valid email
		post password_resets_path,  params: { password_reset: { email: @user.email } }
		assert_not_equal @user.reset_digest, @user.reload.reset_digest
		assert_equal 1, ActionMailer::Base.deliveries.size
		assert_not flash.empty?
		assert_redirected_to root_url
		#Password reset form
		user = assigns(:user)
		#Wrong Email
		get edit_password_reset_path(user.reset_token, email: "")
		assert_redirected_to root_url
		#Inactive user
		user.toggle!(:activated)
		get edit_password_reset_path(user.reset_token, email: user.email)
		assert_redirected_to root_url
		user.toggle!(:activated)
		#Right email, wrong token
		get edit_password_reset_path('wrong token', email: user.email)
		assert_redirected_to root_url
		#Right email, right token
		get edit_password_reset_path(user.reset_token, email: user.email)
		assert_template 'password_resets/edit'
		#Invalid password and confirmation
		patch password_reset_path(user.reset_token), params: { email: user.email, user: { password: "foobar",
																																											password_confirmation: "barfoo" }}
		assert_template 'password_resets/edit'
		#Empty password
		patch password_reset_path(user.reset_token), params: { email: user.email, user: { password: "",
																																											password_confirmation: "" }}
		assert_template 'password_resets/edit'
		#Valid password and confirmation
		patch password_reset_path(user.reset_token), params: { email: user.email, user: { password: "Foobar1!",
																																											password_confirmation: "Foobar1!" }}
		assert is_logged_in?
		assert_not flash.empty?
		assert_redirected_to user
	end



end