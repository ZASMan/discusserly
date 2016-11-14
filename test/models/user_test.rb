require 'test_helper'

class UserTest < ActiveSupport::TestCase

	def setup
		@user = User.new(name: "Example User", email: "user@example.com", password: "Foobar!1", password_confirmation: "Foobar!1")
	end

	test "email addresses should be unique" do
		duplicate_user = @user.dup
		duplicate_user.email = @user.email.upcase
		@user.save
		assert_not duplicate_user.valid?
	end

	test "email addresses should be saved as lower-case" do
		mixed_case_email = "FoO@examPLE.Com"
		@user.email = mixed_case_email
		@user.save
		assert_equal mixed_case_email.downcase, @user.reload.email
	end

	test "password and password confirmation must match" do
		password1 = "foobar"
		password2 = "barfoo"
		@user.password = password1
		@user.password_confirmation = password2
		@user.save
		assert_not @user.valid?
	end

	test "password should not be blank" do
		@user.password = " "
		@user.password_confirmation = " "
		@user.save
		assert_not @user.valid?
	end

	test "password is invalid if less than 6 characters" do
		@user.password = "f" * 3
		@user.password_confirmation = "f" * 3
		@user.save
		assert_not @user.valid?		
	end

	test "password is valid if at least 6 characters" do
		@user.password = "foobar1"
		@user.password_confirmation = "foobar2"
		@user.save
	end

	test "authenticated? should return false for a user with nil digest" do
		assert_not @user.authenticated?(:remember, '')
	end

end
