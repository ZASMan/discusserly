class Profile < ApplicationRecord
  belongs_to :user
	validates :location, presence: true, length: {maximum: 256}
	validates :occupation, presence: true, length: {maximum: 256}
	validates :about_me, presence: true, length: {maximum: 2000}
	#Not validating image_url since it might be a really long link from hosting site
end
