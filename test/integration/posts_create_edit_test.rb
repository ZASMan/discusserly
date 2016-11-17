require 'test_helper'

class PostsEditTest < ActionDispatch::IntegrationTest
	def setup
		title = Faker::Company.catch_phrase
		content = Faker::Hipster.paragraph(2, true, 4)
		@admin = users(:test_user)
		@admin_post = @admin.posts.create!(title: title, content: content)
		@non_admin = users(:second_test_user)
		@non_admin_post = @non_admin.posts.create!(title: title, content: content)
	end

	test "unsuccessful edit will revert to edit page" do
		log_in_as(@admin)
		get edit_post_path(@admin_post)
		patch post_path(@admin_post), params: { post: { title: "", content: ""}}
		assert_template 'posts/edit'
	end

	test "admin user can edit post even if it doesn't belong to them" do
		log_in_as(@admin)
		get edit_post_path(@non_admin_post)
		patch post_path(@non_admin_post), params: { post: { title: "Valid Title", content: "word" * 50 }}
		assert_redirected_to @non_admin_post
	end

	test "non-admin user cannot edit post that does not belong to them" do
		log_in_as(@non_admin)
		get edit_post_path(@admin_post)
		assert_redirected_to root_url
		patch post_path(@admin_post), params: { post: { title: "Valid title", content: "word" * 50 }}
		assert_redirected_to root_url
	end

	test "profane post titles or content will be automatically filtered" do
		log_in_as(@non_admin)
		get new_post_path
		assert_difference 'Post.count', 1 do
			post posts_path, params: {post: {title: "SHIT", content: "ass fuck" }}
		end
		follow_redirect!
		assert_template 'posts/show'
		assert_select 'div.panel-title', text: "[Title filtered due to profanity]."
		assert_select 'p', text: "The content of this post has been filtered due to profanity"
	end
end



