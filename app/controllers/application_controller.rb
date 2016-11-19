class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
	include ApplicationHelper
	include SessionsHelper
	include UsersHelper
	include PostsHelper

	def forbidden
		if current_user.banned?
			render 'application/forbidden'
		else
			redirect_to root_url
		end
	end

	private


end

