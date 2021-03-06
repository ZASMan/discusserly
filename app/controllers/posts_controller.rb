class PostsController < ApplicationController
	before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
	before_action :correct_post_owner, only: [:edit, :update, :destroy]
	before_action :check_banned_user, only: [:index, :show, :new, :create, :edit, :update, :destroy]
	#Note: In the sessions controller, unconfirmed users will be
	#Automatically redirected to root_url and told to confirm email

	def new
		@post = Post.new
	end

	def create
		@post = current_user.posts.build(post_params)
		respond_to do |format|
			if @post.save
				#Redirect to Post
				flash.now[:success] = "Post has been successfully created."
				format.html { redirect_to @post}
				format.json { render :show, status: :created, location: @post }
			else
				format.html {render :new }
				flash[:error] = "Please be sure to add a title and content to your post."
			end
		end
	end

	#Users can only edit/update/destroy a post if that post  belongs to them
	#Or they are administrator
	def edit
		@post = Post.find(params[:id])
	end

	#TODO: Format html on this method
	def update
		@post = Post.find(params[:id])
		if @post.update_attributes(post_params)
			flash.now[:success] = "Post has been successfully updated."
			redirect_to @post
		else
			flash.now[:notice] = "Please fill all required profile fields."
			render 'edit'
		end
	end

	def index
		@posts = Post.all.paginate(page: params[:page])
	end

	def show
		@post = Post.find(params[:id])
		@post_submitted_at = @post.created_at.strftime("%a, %B %d, %Y")
		@users = User.all
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

		#Must check and make sure user is logged in AND banned
		def check_banned_user
			if !current_user.nil? && current_user.banned?
				redirect_to forbidden_path
			end
		end
end
