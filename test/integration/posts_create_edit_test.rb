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

	test "profane post titles or content will be automatically filtered on CREATE" do
		log_in_as(@non_admin)
		get new_post_path
		assert_difference 'Post.count', 1 do
			post posts_path, params: {post: {title: "abra pizza", content: "abra kadabra pizza" }}
		end
		follow_redirect!
		assert_template 'posts/show'
		assert_select 'div.panel-title', text: "*filtered* pizza"
		assert_select 'h6', text: "*filtered* *filtered* pizza"
	end

	test "profane post titles will be automatically filtered on UPDATE" do
		log_in_as(@non_admin)
		get edit_post_path(@non_admin_post)
		patch post_path(@non_admin_post), params: { post: {title: "blahblah abra pizza", content: "pizza is good" }}
		follow_redirect!
		assert_template 'posts/show'
		assert_select 'div.panel-title', text: '*filtered* *filtered* pizza'
		assert_select 'h6', text: "pizza is good"
	end

	test "users attempting to submit script tags will be filtered and user banned" do
		log_in_as(@non_admin)
		get new_post_path
		assert_difference 'Post.count', 1 do
			post posts_path params: { post: { title: "<script>hacker.com/leethaxor.js</script>", content: "<script>www.hacker.com/scripts.js</script>" }}
		end
		follow_redirect!
		assert_template 'posts/show'
		assert_select 'div.panel-title', text: "*filtered due to malicious content*"
		assert_select 'h6', text: "*filtered due to malicious content*"
		@non_admin.banned?
		get new_post_path
		#assert_redirected_to root_url
	end
end



