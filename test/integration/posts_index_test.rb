require 'test_helper'

class PostsIndexTest < ActionDispatch::IntegrationTest
	
	def setup
		title = Faker::Company.catch_phrase
		content = Faker::Hipster.paragraph(2, true, 4)
		@admin = users(:test_user)
		@non_admin = users(:second_test_user)
		@non_admin_post = @non_admin.posts.create!(title: title, content: content)
		@non_admin_2 = users(:third_test_user)
	end

	#Admin has no posts created for them, so we'll assume they can see non_admin_post 
	test "edit and delete buttons do not display for non admin users" do
		log_in_as(@admin)
		get posts_path
		#Edit Button has btn.btn.warning class
		assert_select 'a.btn.btn-warning'
		#Destroy button has btn.btn-danger class
		assert_select 'a.btn.btn-danger'
	end

	#Non Admin 2 has no posts created for them
	test "edit and delete buttons only display for non admin users if the post belongs to them" do
		log_in_as(@non_admin_2)
		get posts_path
		assert_select 'a.btn.btn-warning', 0
		assert_select 'a.btn.btn-danger', 0
	end

end
