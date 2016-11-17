class PostsController < ApplicationController
	before_action :logged_in_user, only: [:new, :edit, :update, :destroy]
	before_action :correct_post_owner, only: [:edit, :update, :destroy]
	#Note: In the sessions controller, unconfirmed users will be
	#Automatically redirected to root_url and told to confirm email

	def new
		@post = Post.new
		render 'new'
	end

	def create
		@post = current_user.posts.build(post_params)
		respond_to do |format|
			if @post.save
				#Update attributes if contain profanity
				profane_words = %w(ass bastard bitch cock damn fuck shit)
				post_title = @post.title.split(" ")
				post_content = @post.content.split(" ")
				post_title.each do |word|
					if profane_words.include?(word)
						@post.safe_title
					end
				end
				post_content.each do |word|
					if profane_words.include?(word)
						@post.safe_content
					end
				end
				#Redirect to Post
				format.html { redirect_to @post}
				format.json { render :show, status: :created, location: @post }
			else
				format.html {render :new }
				flash[:error] = "Unable to create post"
			end
		end
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
		if @post.update_attributes(post_params)
				#Update attributes if contain profanity
				profane_words = %w(ass bastard bitch cock damn fuck shit)
				post_title = @post.title.downcase.split(" ")
				post_content = @post.content.downcase.split(" ")
				post_title.each do |word|
					if profane_words.include?(word)
						@post.safe_title
					end
				end
				post_content.each do |word|
					if profane_words.include?(word)
						@post.safe_content
					end
				end
			flash.now[:success] = "Post has been successfully updated."
			redirect_to @post
		else
			render 'edit'
		end
	end

	def index
		@posts = Post.all.paginate(page: params[:page])
	end

	def show
		@post = Post.find(params[:id])
		@post_submitted_at = @post.created_at.strftime("%a, %B %d, %Y")
		render 'show'
	end

	def destroy
		Post.find(params[:id]).destroy
		flash[:success] = "Post successfully deleted"
		redirect_to posts_url
	end

	private
		
		def post_params
			params.require(:post).permit(:title, :content)
		end
end
