class Post < ApplicationRecord
  belongs_to :user
	default_scope -> { order(created_at: :desc) }
	before_save :check_profanity
	validates :title, presence: true, length: {maximum: 256}
	validates :user_id, presence: true
	validates :content, presence: true, length: {maximum: 1500}

	def check_profanity
		profane_words = %w(ass bastard bitch damn fuck shit)
		post_title_arr = self.title.downcase.split(" ")
		post_content_arr = self.content.downcase.split(" ")
		filter = ["*filtered*"]
		post_title_arr.map! { |word| profane_words.include?(word) ? filter : word}.flatten!
		self.title = post_title_arr.join(" ")
		post_content_arr.map! { | word| profane_words.include?(word) ? filter : word}.flatten!
		self.content = post_content_arr.join(" " )
	end
end
