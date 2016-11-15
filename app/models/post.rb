class Post < ApplicationRecord
  belongs_to :user
	default_scope -> { order(created_at: :desc) }
	validates :title, presence: true, length: {maximum: 256}
	validates :user_id, presence: true
	validates :content, presence: true, length: {maximum: 1500}
	
	#Update post to show name of author
	def self.update_created_by(creator)
		update_attribute(:created_by, current_user)
	end
end
