require 'mailchimp'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :setup_mcapi
  def setup_mcapi
  	@mc = Mailchimp::API.new('60bb001679ec500e529f898a988c6d65-us3')
  	@list_id = "b12ad873fb"
  end

  def authorize_admin
  	redirect_to(signin_path) unless current_user && current_user.email == 'alexzotov8@gmail.com'
    #redirects to previous page
  end


end
