class User < ApplicationRecord
	
	before_save { email.downcase! }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	#has_secure_password is from the BCrypt gem. It gives us the:
	#1.Ability to save a securely hashed password_digest attribute to database
	#2.A pair of virtual (meaning they exist on the model object but do not correspond to columns 
	#in the database attributes (password and password_confirmation) including presence validations upon object
	#creation and a validation requiring that they match, 3. An authenticate method that returns the user when the password is correct	
	has_secure_password
	validates :password, presence: true, length: {minimum: 6}
end
