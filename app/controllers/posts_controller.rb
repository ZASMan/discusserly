class PostsController < ApplicationController
	#The final implementation will be that users can only
	#edit, update, and destroy their own posts
	#Unless they are an admin user
	before_action :logged_in_user, only: [:new, :edit, :update, :destroy]
	#The correct_post_owner method checks to assure that the post
	#has the same user_id as the user who created the post
	#Unless that user is an admin
	before_action :correct_post_owner, only: [:edit, :update, :destroy]
	#Note: In the sessions controller, unconfirmed users will be
	#Automatically redirected to root_url and told to confirm email

	#Only logged in users can see the create new posts page
	def new
		@post = Post.new
		render 'new'
	end

	#Only logged in users can create a new post
	def create
		@post = current_user.posts.build(post_params)
		respond_to do |format|
			if @post.save
				format.html { redirect_to @post}
				format.json { render :show, status: :created, location: @post }
			else
				format.html {render :new }
				flash[:error] = "Unable to create post"
			end
		end
	end


	#Users can only edit their own posts (unless they're an admin)
	def edit
		@post = Post.find(params[:id])
	end

	#Users can only update their own posts (unless they're admins)
	def update
		@post = Post.find(params[:id])
		if @post.update_attributes(post_params)
			flash.now[:success] = "Post has been successfully updated."
			redirect_to @post
		else
			render 'edit'
		end
	end


	#Post index viewable to public
	def index
		@posts = Post.all.paginate(page: params[:page])
	end

	#Posts are viewable to public
	def show
		@post = Post.find(params[:id])
		@post_submitted_at = @post.created_at.strftime("%a, %B %d, %Y")
	end

	#Only admins or correct post owners can destroy posts
	def destroy
		Post.find(params[:id]).destroy
		flash[:success] = "Post successfully deleted"
		redirect_to users_url
	end

	private
		
		def post_params
			params.require(:post).permit(:title, :content)
		end



end
