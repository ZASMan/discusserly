require 'test_helper'

class CommentTest < ActionDispatch::IntegrationTest

	def setup
		@admin = users(:test_user)
		@non_admin = users(:second_test_user)
		@non_admin_2 = users(:third_test_user)
		@admin_post = @admin.posts.create!(title: "Title of post", content: "Content of post")
		@non_admin_post = @non_admin.posts.create!(title: "Title of post", content: "Content of post")
		@admin_comment = @non_admin_post.comments.build(body: "Comment")
		@admin_comment_1 = @admin_post.comments.build(body: 'Comment')
		@non_admin_comment = @non_admin_post.comments.build(body: "Comment")
		@non_admin_2_comment_1 = @admin_post.comments.build(body: "Comment")
		@non_admin_2_comment_2 = @non_admin_post.comments.build(body: "Comment")
	end

	#Admin had created one comment on admin post, so that will be comment to assert
	#Delete button doesn't exist for
	test "non admin cannot see delete button for comments on admin post" do
		log_in_as(@non_admin)
		get post_path(@admin_post)
		assert_select 'a', text: 'Delete Comment', count: 0
	end

	test "admin can see delete button on comments on non admin post" do
		log_in_as(@admin)
		get post_path(@non_admin_post)
		assert_select 'a', text: 'Delete Comment', count: 0
	end
	
	#test "body being submitted with profanity will be filtered" do
	#	log_in_as(@non_admin)
	#	get post_path(@admin_post)
	#	#Comment Path for the Post here
	#	get post_path(@admin_post)
	#	assert_select 'p', text: '*filtered*', count: 1
	#end

end
