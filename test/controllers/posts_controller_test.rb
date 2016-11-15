require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest


	def setup
		@admin = users(:test_user)
		@non_admin = users(:second_test_user)
	end


	#test "should redirect edit when not admin or the post owner" do
	#	log_in_as(@non_admin)
		#Go to url of a post with the admin user ID
	#	assert_redirected_to root_url
	#end




end
