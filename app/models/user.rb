class User < ApplicationRecord
	attr_accessor :remember_token
	#Ensure Email Uniqueness by Downcasing the Email Attribute
	before_save {self.email = email.downcase }
	#Validate presence, length, format, and uniqueness (ignoring case)
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: {maximum: 250}, format: {with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false}
	#Adds ability to save securely hashed password_digest attribute to database
	#Adds a pair of virtual attributes (password and password_confirmation)
	#including presence validations upon object creation and a validation
	#requiring that they match
	#adds authenticate method that returns the user when the password is correct (and false otherwise)
	has_secure_password
	PASSWORD_FORMAT = /\A
		(?=.{8,})          # Must contain 8 or more characters
  		(?=.*\d)           # Must contain a digit
  		(?=.*[a-z])        # Must contain a lower case character
  		(?=.*[A-Z])        # Must contain an upper case character
  		(?=.*[[:^alnum:]]) # Must contain a symbol
	/x
	validates :password, presence: true, length: {minimum: 8}, format: {with: PASSWORD_FORMAT}
	validates :password_confirmation, presence: true
	#Returns the hash digest of the given string
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
													 BCrypt::Engine.cost
     BCrypt::Password.create(string, cost: cost)
 	end

	#Returns a random token.
  def User.new_token
   	SecureRandom.urlsafe_base64
  end

  #Remembers a user in the database for use in persistent sessions
  def remember
  	self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	#Returns true if the given token matches the digest
	def authenticated?(remember_token)
		return false if remember_digest.nil?
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end
	
	#Forgets a user
	def forget
		update_attribute(:remember_digest, nil)
	end

end
