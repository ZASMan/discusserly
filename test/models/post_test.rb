require 'test_helper'

class PostTest < ActiveSupport::TestCase
	
	def setup
		@user = users(:test_user)
		#Build creates a post associated with user
		@post = @user.posts.build(title: "Post", content: "Lorem ipsum")
	end

	test "should be valid" do
		assert @post.valid?
	end

	test "user id should be present" do
		@post.user_id = nil
		assert_not @post.valid?
	end

	test "title should be present" do
		@post.title = nil
		assert_not @post.valid?
	end

	test "title should be less than 256 characters" do
		@post.title = "a" * 300
		assert_not @post.valid?
	end

	test "content should be present" do
		@post.content = nil
		assert_not @post.valid?
	end
	
	test "content should be less than 1000 characters" do
		@post.content = "a" * 2000
		assert_not @post.valid?
	end

	test "order should be the most recent first" do
		assert_equal posts(:most_recent), Post.first
	end

end
