class Comment < ApplicationRecord
	include ContentFilter
	belongs_to :commentable, polymorphic: true
	validates :body, presence: true, length: {maximum: 3000}
	before_save :check_profanity

	def check_profanity
		#Profane Words in ContentFilter module
		comment_body_arr = self.body.downcase.split(" ")
		filter = ["*filtered*"]
		comment_body_arr.map! { |word| $profane_words.include?(word) ? filter : word}.flatten!
		self.body = comment_body_arr.join(" ")
	end
end
