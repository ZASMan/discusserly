require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:test_user)
	end

	test "unsuccessful edit" do
		log_in_as(@user)
		get edit_user_path(@user)
		patch user_path(@user), params: { user: { email: "test@invalid",
																							password: "foo",
																							password_confirmation: "bar"}}
		assert_redirected_to edit_user_path
	end

	test "successful edit" do
		log_in_as(@user)	
		get edit_user_path(@user)
		email = 'test@test.com'
		patch user_path(@user), params: { user: {email: 'test_email@test.com',
																						password: "Foobar1!",
																						password_confirmation: "Foobar1!"}}
		assert_redirected_to @user
	end
	
	test "only admins can see/update the banned option in the edit view" do
	end
end
