class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  def new
    @home_page = true
    @user = User.new
  end

  def edit
   @home_page = true
   @user = User.find(params[:id])
 end


 def update
  @home_page = true
  @user = User.find(params[:id])
  if @user.update_attributes(user_params)
    flash[:success] = "Profile updated"
    redirect_to session.delete(:return_to)
  else
    render 'edit'
  end
end

def create
  @user = User.new(user_params)
  @user.password_confirmation = @user.password
  if @user.save
    sign_in @user
    WelcomeMailer.registration_confirmation(@user).deliver
    flash[:success] = "Thank you for signing up with Fitcasts."
    redirect_to session.delete(:return_to)
  else
    render 'new'
  end
end

private
def user_params
  params.require(:user).permit(:name, :email, :password,
   :password_confirmation, :admin, :client, :trainer, :oauth_secret, :oauth_token, :timezone)
end

def signed_in_user
  unless signed_in?
    store_location
    redirect_to signin_url, notice: "Please sign in."
  end
end

def correct_user
  @user = User.find(params[:id])
  redirect_to session.delete(:return_to) unless current_user?(@user)
end
end
