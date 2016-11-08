class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
	include SessionsHelper

	def landing_page
		respond_to do |format|
			format.html { render "_landing_page.html.haml", layout: "application.html.erb"}
		end
	end

end

