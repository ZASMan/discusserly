class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
	include SessionsHelper
	include UsersHelper
	include PostsHelper

	def landing_page
		render "_landing_page"
	end


	private


end

