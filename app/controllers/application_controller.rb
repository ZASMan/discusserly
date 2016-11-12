class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
	include SessionsHelper

	def landing_page
		render "_landing_page"
	end

end

