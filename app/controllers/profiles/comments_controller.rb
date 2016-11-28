class Profiles::CommentsController < CommentsController

	before_action :set_commentable

	private

		def set_commentable
			@commentable = Profile.find(params[:profile_id])
		end
end
