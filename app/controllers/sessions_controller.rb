class SessionsController < ApplicationController
  def new
    @home_page = true
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase.strip)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      
      redirect_to session.delete(:return_to)
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
