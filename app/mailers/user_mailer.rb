class UserMailer < ActionMailer::Base
	

	def password_reset(user)
		@user = user
		mail :to => @user.email, :from => "alexzotov@fitcasts.com", :subject => "Password Reset"
	end
end
