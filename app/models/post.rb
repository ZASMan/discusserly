class Post < ApplicationRecord
	include ContentFilter
	belongs_to :user
	has_many :comments, as: :commentable
	default_scope -> { order(created_at: :desc) }
	before_save :check_profanity
	validates :title, presence: true, length: {maximum: 256}
	validates :user_id, presence: true
	validates :content, presence: true, length: {maximum: 1500}

	def check_profanity
		#Profane Words in ContentFilter module
		post_title_arr = self.title.downcase.split(" ")
		post_content_arr = self.content.downcase.split(" ")
		filter = ["*filtered*"]
		post_title_arr.map! { |word| $profane_words.include?(word) ? filter : word}.flatten!
		self.title = post_title_arr.join(" ")
		post_content_arr.map! { | word| $profane_words.include?(word) ? filter : word}.flatten!
		self.content = post_content_arr.join(" " )
	end
end
