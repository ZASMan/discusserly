require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

	def setup
		@admin_user = users(:test_user)
		@non_admin = users(:second_test_user)
		@unconfirmed_user = users(:unconfirmed_test_user)
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
				assert_select 'a', text: user.name
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
end
