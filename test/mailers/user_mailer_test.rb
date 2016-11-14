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

	#test "pasword_rest" do
		#mail = UserMailer.password_reset
		#assert_equal "Password reset", mail.subject
		#assert_equal ["to@example.org"], mail.to
		#assert_equal ["noreply@example.com"], mail.from
		#assert_match "Hi", mail.body.encoded
	#end


end
