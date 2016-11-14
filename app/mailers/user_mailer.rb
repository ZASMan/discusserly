class UserMailer < ApplicationMailer
  
	def account_activation(user)
    @user = user
		mail to: user.email, subject: "Account Activation with Discusserly"
  end

  def password_reset(user)
    @user = user
  	mail to: user.email, subject: "Password Reset with Discusserly"
	end
end
