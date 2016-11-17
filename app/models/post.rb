class Post < ApplicationRecord
  belongs_to :user
	default_scope -> { order(created_at: :desc) }
	before_save :check_profanity, :check_javascript
	validates :title, presence: true, length: {maximum: 256}
	validates :user_id, presence: true
	validates :content, presence: true, length: {maximum: 1500}

	#Disallow Script Tags, especially important for :content attribute since show allows html_safe due to ckeditor on create/edit text area
	def check_javascript
		#Unlike check profanity, leave it as string rather than array (in case the user simply submitted one long tag with no spaces)
		#That way it won't matter if checking for spaces just substring
		script_tags = %w(<script> </script> %script .js)
		post_title_str = self.title.downcase
		post_content_str = self.content.downcase
		#Automatically ban user if scripts are found in post title or content string
		if post_title_str.include? "<script>" or post_title_str.include? "</script>" or post_title_str.include? ".js" or post_title_str.include? "%script" or post_content_str.include? "<script>" or post_content_str.include? "</script>" or post_content_str.include? ".js" or post_content_str.include? "%script"
			self.user.banned = true
			if self.user.banned?
				puts "User is banned"
			else
				puts "User is not banned"
			end
			self.title = "*filtered due to malicious content*"
			self.content = "*filtered due to malicious content*"
		end
	end

	def check_profanity
		profane_words = %w(abra kadabra blahblah)
		post_title_arr = self.title.downcase.split(" ")
		post_content_arr = self.content.downcase.split(" ")
		filter = ["*filtered*"]
		post_title_arr.map! { |word| profane_words.include?(word) ? filter : word}.flatten!
		self.title = post_title_arr.join(" ")
		post_content_arr.map! { | word| profane_words.include?(word) ? filter : word}.flatten!
		self.content = post_content_arr.join(" " )
	end
end
