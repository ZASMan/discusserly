class Post < ApplicationRecord
  belongs_to :user
	default_scope -> { order(created_at: :desc) }
	validates :title, presence: true, length: {maximum: 256}
	validates :user_id, presence: true
	validates :content, presence: true, length: {maximum: 1500}
=begin
	def check_profanity
		#Convert the title and content attributes to array 
		#Loop through the arrays and if they are contained in the
		#Profanity array, change it to [filtered] and save to array
		#convert the new array to string and update_attribute
	end
=end

end
