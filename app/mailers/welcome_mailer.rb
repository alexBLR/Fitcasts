class WelcomeMailer < ActionMailer::Base
	def registration_confirmation(user)
		@user = user
		mail :to => @user.email, :from => "alexzotov@fitcasts.com", :subject => "Welcome to Fitcasts!"
	end
end