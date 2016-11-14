require 'test_helper'

class UserMailertest < ActionMailer::TestCase

	test "account_activation" do
		user = users(:test_user)
		user.activation_token = User.new_token
		mail = UserMailer.account_activation(user)
		assert_equal "Account Activation with Discusserly", mail.subject
		assert_equal [user.email], mail.to
		assert_equal ["noreply@example.com"], mail.from
		assert_match user.name, mail.body.encoded

	end

	test "password_reset" do
		user = users(:test_user)
		user.reset_token = User.new_token
		mail = UserMailer.password_reset(user)
		assert_equal "Password Reset with Discusserly", mail.subject
		assert_equal [user.email], mail.to
		assert_equal ["noreply@example.com"], mail.from
		assert_match user.reset_token, mail.body.encoded
	end
end
