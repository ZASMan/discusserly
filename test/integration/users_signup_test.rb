require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

	test "invalid signup information" do
		get signup_path
		assert_no_difference 'User.count' do
			post users_path, params: {user: { name: "", email: "user@invalid",
																				password: "foo",
																				password_conirmation: "bar"}}
		end
		assert_template 'users/new'
	end

	#Please make note to the PASSWORD_FORMAT in app/models/user.rb
	test "valid signup information" do
		get signup_path
		assert_difference 'User.count', 1 do
			post users_path, params: {user: { name: "Valid User", email: "user@valid.com",
																				password: "Foobar#1",
																				password_confirmation: "Foobar#1"}}
		end
		follow_redirect!
		assert_select 'h1', count: 1
	end
end
