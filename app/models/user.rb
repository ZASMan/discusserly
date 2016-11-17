class User < ApplicationRecord
	#User has many posts which wil be destroyed if user destroyed
	has_many :posts, dependent: :destroy
	attr_accessor :remember_token, :activation_token, :reset_token
	#Create an activation digest for user to register account
	before_create :create_activation_digest
	#Ensure Email Uniqueness by Downcasing the Email Attribute
	before_save :downcase_email
	#Validate presence, length, format, and uniqueness (ignoring case)
	validates :name, presence: true, length: { maximum: 50 }
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
	def authenticated?(attribute, token)
		digest = send("#{attribute}_digest")
		return false if digest.nil?
		BCrypt::Password.new(digest).is_password?(token)
	end
	
	#Forgets a user
	def forget
		update_attribute(:remember_digest, nil)
	end
	
	#Activates account
	def activate
		update_attribute(:activated, true)
		update_attribute(:activated_at, Time.zone.now)
	end

	#Sends activation email
	def send_activation_email
		UserMailer.account_activation(self).deliver_now
	end

	#Sets the password reset attributes
	def create_reset_digest
		self.reset_token = User.new_token
		update_attribute(:reset_digest, User.digest(reset_token))
		update_attribute(:reset_sent_at, Time.zone.now)
	end

	#Sends password reset email
	def send_password_reset_email
		UserMailer.password_reset(self).deliver_now
	end

	#Returns true if a password reset has expired
	def password_reset_expired?
		reset_sent_at < 2.hours.ago
	end

	private

		def downcase_email
			self.email = email.downcase
		end

		#Creates and assigns the actiation token and digest.
		#The code for this method is reused from the token and digest
		#methods for the remember token. The maind ifference is that remember
		#tokens and digests are created for users that already exist in the db,
		#but the before_create callback happens before the user has been created
		#So there is no attribute to update. As a result of the callback,
		#When a new uer is defined with User.new (user signup), it will
		#automaticlaly get both activation_token and activation_digest attributes 
		#which will be written to the database when the user is saved	
		def create_activation_digest
			self.activation_token = User.new_token
			self.activation_digest = User.digest(activation_token)
		end

end
